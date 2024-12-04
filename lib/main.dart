import 'dart:async';
import 'dart:io';

import 'package:catcher_2/core/catcher_2.dart';
import 'package:catcher_2/model/catcher_2_options.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fstation/bloc/app_setting_bloc.dart';
import 'package:fstation/extension/context_extension.dart';
import 'package:fstation/generated/l10n.dart';
import 'package:fstation/impl/router.dart';
import 'package:fstation/util/app_info.dart';
import 'package:fstation/util/app_window.dart';
import 'package:fstation/util/catcher/catcher_util.dart';
import 'package:fstation/util/constants.dart';
import 'package:fstation/util/dependency_injection.dart';
import 'package:fstation/util/device_info.dart';
import 'package:fstation/util/http_override.dart';
import 'package:fstation/util/local_host_discover.dart';
import 'package:fstation/util/network_util.dart';
import 'package:fstation/util/path_util.dart';
import 'package:fstation/util/util.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:worker_manager/worker_manager.dart';

import 'bloc/auth_form_bloc.dart';
import 'bloc/auth_session_bloc.dart';
import 'generated/error.pbenum.dart';
import 'impl/grpc_client.dart';
import 'impl/logger.dart';
import 'impl/setting_impl.dart';
import 'impl/store.dart';
import 'impl/user_manager.dart';
import 'util/themes.dart';

Future<void> checkAndConnectServer() async {
  if (SettingImpl.instance.serverUuid.isNotEmpty) {
    final discover = LocalHostDiscover.instance;
    await discover.discoverServices();

    bool serverFound = false;
    for (final service in discover.services) {
      try {
        // Try to connect and handshake with each discovered server
        final client = GrpcClient.instance;
        final parts = service.split(':');
        if (parts.length == 2) {
          await client.connect(parts[0], int.parse(parts[1]));
          final response = await client.handshake();

          if (response.errCode == ErrCode.Success &&
              response.serverUuid == SettingImpl.instance.serverUuid) {
            // Found matching server
            serverFound = true;
            if (service != SettingImpl.instance.serverAddr) {
              await SettingImpl.instance.saveServerAddr(service);
            }
            await grpcClientInit();
            break;
          }
        }
      } catch (e) {
        Logger.error('Failed to connect to discovered server: $service', e);
        continue;
      }
    }

    if (!serverFound) {
      Logger.warning(
          'Known server (UUID: ${SettingImpl.instance.serverUuid}) not found');
      await SettingImpl.instance.saveServerConnectionFailed(true);
    }
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // GestureBinding.instance.resamplingEnabled = true;
  final systemLocale = PlatformDispatcher.instance.locale;
  await Localization.load(systemLocale);
  Catcher2Options? catcherOptions;
  try {
    // execute simultaneously
    await Future.wait([
      setHighRefreshRate(),
      workerManager.init(),
      AppInfo.instance.init(),
      DeviceInfo.init(),
    ]);

    configureDependencies();

    /// scheduleMicrotask is used to queue a function to be executed in the
    /// microtask queue, which is processed before the event queue. This ensures
    /// that the function runs as soon as the current synchronous code execution
    /// completes, but before any I/O events or timers
    scheduleMicrotask(() async {
      await PathUtil.instance.init();
      await Logger.instance.init();
    });

    await ConnectivityUtil.instance.init();
    await Store.instance.init();
    await UserManager.instance.init();
    await SettingImpl.instance.init();
    await WindowUtil.init();

    await checkAndConnectServer();

    if (!kIsWeb) {
      HttpOverrides.global = CustomHttpOverrides();
    }

    catcherOptions = CatcherUtil.getOptions();
  } catch (e, s) {
    Logger.error('Init app failed at startup', e, s);
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
    } catch (e, s) {
      Logger.error('Error setting high refresh rate', e, s);
    }
  }
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
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
        overlayStyle = context.isDarkMode
            ? SystemUiOverlayStyle.dark
            : SystemUiOverlayStyle.light;
      }
    }
    SystemChrome.setSystemUIOverlayStyle(overlayStyle);
    // TODO(xieyz): local notification
    // await ref.read(localNotificationService).setup();
  }

  @override
  void initState() {
    super.initState();

    // Load localization using the system locale
    initApp();
    Future.microtask(() => getIt<AppSettingBloc>().add(LoadSettingsEvent()));

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

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // final systemLocale = PlatformDispatcher.instance.locale;
    // Localization.load(systemLocale);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppSettingBloc>(
          create: (context) => getIt<AppSettingBloc>(),
        ),
        BlocProvider<AuthFormBloc>(
          create: (context) => getIt<AuthFormBloc>(),
        ),
        BlocProvider<AuthSessionBloc>(
          create: (context) => getIt<AuthSessionBloc>(),
        ),
      ],
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
            theme: AppThemes.instance.lightThemeData,
            darkTheme: AppThemes.instance.darkThemeData,
            themeMode: state.themeMode,
            routerConfig: router,
            localizationsDelegates: const [
              Localization.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            locale: getLocale(state.language),
            supportedLocales: Localization.delegate.supportedLocales,
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
