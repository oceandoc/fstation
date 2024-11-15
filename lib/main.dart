import 'dart:async';
import 'dart:io';

import 'package:catcher_2/core/catcher_2.dart';
import 'package:catcher_2/model/catcher_2_options.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fstation/bloc/app_setting_bloc.dart';
import 'package:fstation/generated/l10n.dart';
import 'package:fstation/impl/router.dart';
import 'package:fstation/util/analysis/analysis.dart';
import 'package:fstation/util/app_device_info.dart';
import 'package:fstation/util/app_window.dart';
import 'package:fstation/util/catcher/catcher_util.dart';
import 'package:fstation/util/extensions.dart';
import 'package:fstation/util/http_override.dart';
import 'package:fstation/util/language.dart';
import 'package:fstation/util/network.dart';
import 'package:fstation/util/path_help.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:worker_manager/worker_manager.dart';

import 'impl/logger.dart';
import 'impl/setting_impl.dart';
import 'impl/store.dart';
import 'impl/user_manager.dart';
import 'ui/themes.dart';

// TODO(xieyz): fix Localization initialize exception
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // GestureBinding.instance.resamplingEnabled = true;

  /// scheduleMicrotask is used to queue a function to be executed in the
  /// microtask queue, which is processed before the event queue. This ensures
  /// that the function runs as soon as the current synchronous code execution
  /// completes, but before any I/O events or timers
  scheduleMicrotask(() async {
    await PathHelper().init();
    Logger();
  });

  await Store.instance.init();
  await UserManager.instance.init();

  final systemLocale = PlatformDispatcher.instance.locale;
  await Localization.load(systemLocale);

  // execute simultaneously
  await Future.wait([
    setHighRefreshRate(),
    fetchSystemPalette(),
  ]);

  await SettingImpl.instance.init();

  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
    Sentry.captureException(details);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    Sentry.captureException(error, stackTrace: stack);
    return true;
  };

  Catcher2Options? catcherOptions;
  try {
    await AppWindowUtil.init();
    await workerManager.init();
    await network.initialize();
    if (!kIsWeb) {
      HttpOverrides.global = CustomHttpOverrides();
    }
    await Store.instance.init();
    await AppAnalysis.instance.initiate();
    catcherOptions = CatcherUtil.getOptions();
  } catch (e, s) {
    Logger.error('initiate app failed at startup', e, s);
    if (kDebugMode) {
      print(e);
      print(s);
    }
  }

  if (kDebugMode) {
    runApp(const App());
  } else {
    Catcher2(
      rootWidget: const App(),
      debugConfig: catcherOptions,
      profileConfig: catcherOptions,
      releaseConfig: catcherOptions,
      navigatorKey: kAppKey,
      ensureInitialized: true,
    );
  }
}

Future<void> setHighRefreshRate() async {
  if (kReleaseMode && Platform.isAndroid) {
    try {
      await FlutterDisplayMode.setHighRefreshRate();
    } catch (e) {
      debugPrint('Error setting high refresh rate: $e');
    }
  }
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();

    // Load localization using the system locale
    initApp();
    Future.microtask(
        () => context.read<AppSettingBloc>().add(LoadSettingsEvent()));

    // TODO(xieyz): background task
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   // needs to be delayed so that EasyLocalization is working
    //   ref.read(backgroundServiceProvider).resumeServiceIfEnabled();
    // });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      UserManager.instance.updateToken();
    }
  }

  Future<void> initApp() async {
    WidgetsBinding.instance.addObserver(this);
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    var overlayStyle = const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
    );
    if (Platform.isAndroid) {
      // Android 8 does not support transparent app bars
      final info = await DeviceInfoPlugin().androidInfo;
      if (info.version.sdkInt <= 26) {
        overlayStyle = context.isDarkTheme
            ? SystemUiOverlayStyle.dark
            : SystemUiOverlayStyle.light;
      }
    }
    SystemChrome.setSystemUIOverlayStyle(overlayStyle);
    // TODO(xieyz): local notification
    // await ref.read(localNotificationService).setup();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Ensure localization is loaded
    final systemLocale = PlatformDispatcher.instance.locale;
    Localization.load(systemLocale);

    // TODO(xieyz): app life cycle handler
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppSettingBloc(),
      child: ResponsiveBreakpoints.builder(
        breakpoints: [
          const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
        child: BlocBuilder<AppSettingBloc, AppSettingState>(
          builder: (context, state) => MaterialApp.router(
            title: 'fStation',
            theme: AppThemes.instance.getAppTheme(true),
            darkTheme: AppThemes.instance.getAppTheme(false),
            themeMode: state.themeMode,
            routerConfig: router,
            localizationsDelegates: const [
              Localization.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            locale: Language.getLanguage(state.language).locale,
            supportedLocales: Language.supportLanguages
                .map((language) => language.locale)
                .toList(),
            localeResolutionCallback: (locale, supportedLocales) {
              for (final supportedLocale in supportedLocales) {
                if (supportedLocale.languageCode == locale?.languageCode &&
                    supportedLocale.countryCode == locale?.countryCode) {
                  return supportedLocale;
                }
              }
              return supportedLocales.first;
            },
          ),
        ),
      ),
    );
  }
}
