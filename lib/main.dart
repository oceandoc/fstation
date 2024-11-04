import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fstation/bloc/app_setting_bloc.dart';
import 'package:fstation/routing/router.dart';
import 'package:fstation/util/color.dart';
import 'package:fstation/util/language.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'impl/db.dart';
import 'impl/setting.dart';
import 'ui/theme/themes.dart';
import 'package:fstation/generated/l10n.dart';

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

  await loadDb();
  await SettingImpl.instance.init();
  runApp(Provider<SettingImpl>.value(
      value: SettingImpl.instance, child: const App()));
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
    Future.microtask(
        () => context.read<AppSettingBloc>().add(LoadSettingsEvent()));
  }

  @override
  Widget build(BuildContext context) {
    final settingImpl = Provider.of<SettingImpl>(context);

    final theme = AppThemes.inst.getAppTheme();

    return BlocProvider(
      create: (context) => AppSettingBloc(settingImpl),
      child: BlocBuilder<AppSettingBloc, AppSettingState>(
        builder: (context, state) => MaterialApp.router(
          title: 'fStation',
          theme: theme,
          routerConfig: router,
          localizationsDelegates: const [
            Localization.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          locale: Language.getLanguage(settingImpl.language).locale,
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
    );
  }
}
