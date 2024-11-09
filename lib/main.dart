import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fstation/bloc/app_setting_bloc.dart';
import 'package:fstation/generated/l10n.dart';
import 'package:fstation/impl/router.dart';
import 'package:fstation/util/language.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'impl/db.dart';
import 'impl/setting.dart';
import 'ui/themes.dart';

// TODO(xieyz): fix Localization initialize exception
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
    Sentry.captureException(details);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    Sentry.captureException(error, stackTrace: stack);
    return true;
  };

  final systemLocale = PlatformDispatcher.instance.locale;
  await Localization.load(systemLocale);

  await loadDb();
  await SettingImpl.instance.init();
  runApp(const App());
}

Future<Isar> loadDb() async {
  final dir = await getApplicationDocumentsDirectory();
  final db = await Isar.open(
    [
      DbValueSchema,
    ],
    directory: dir.path,
  );
  return db;
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();

    // Load localization using the system locale

    Future.microtask(
        () => context.read<AppSettingBloc>().add(LoadSettingsEvent()));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Ensure localization is loaded
    final systemLocale = PlatformDispatcher.instance.locale;
    Localization.load(systemLocale);
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
