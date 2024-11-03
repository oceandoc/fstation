import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fstation/bloc/app_setting_bloc.dart';
import 'package:fstation/routing/router.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'impl/db.dart';
import 'impl/setting.dart';
import 'util/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();

  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
    Sentry.captureException(details);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    Sentry.captureException(error, stackTrace: stack);
    return true;
  };

  final db = await loadDb();
  final settingImpl = SettingImpl();
  runApp(Provider<SettingImpl>.value(value: settingImpl, child: App()));
}

Future<Isar> loadDb() async {
  final dir = await getApplicationDocumentsDirectory();
  Isar db = await Isar.open(
    [
       DbValueSchema,
    ],
    directory: dir.path,
    maxSizeMiB: 1024,
  );
  return db;
}

class App extends StatefulWidget {
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
  }

  Color _getThemeColor(String themeColor) {
    switch (themeColor) {
      case 'red':
        return Colors.red;
      case 'green':
        return Colors.green;
      case 'blue':
      default:
        return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    final settingImpl = Provider.of<SettingImpl>(context);
    return BlocProvider(
      create: (context) => AppSettingBloc(settingImpl),
      child: BlocBuilder<AppSettingBloc, AppSettingState>(
        builder: (context, state) =>
            MaterialApp.router(
              title: 'fStation',
              theme: ThemeData(
                brightness:
                state.themeStyle == 'dark' ? Brightness.dark : Brightness.light,
                primaryColor: _getThemeColor(state.themeColor),
              ),
              routerConfig: router,
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              locale: locales.first,
              supportedLocales: locales,
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
