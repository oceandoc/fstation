import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fstation/routing/router.dart';
import 'package:fstation/ui/theme/app_theme.dart';
import 'package:fstation/util/error_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import 'bloc/theme_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();
  ErrorHandler(builder: () async => App());
}

class App extends StatefulWidget {
  final FlutterLocalization localization = FlutterLocalization.instance;
  App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    widget.localization.init(
      mapLocales: [],
      // initLanguageCode: initLanguage == '' ? defaultLanguage : initLanguage,
      initLanguageCode: 'zh-CHS',
    );

    widget.localization.onTranslatedLanguage = (Locale? locale) {
      setState(() {});
    };
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeData>(
        builder: (context, theme) {
          return MaterialApp.router(
            title: 'Flutter Demo',
            theme: theme,
            routerConfig: router,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en', ''), // English
              Locale('es', ''), // Spanish
            ],
          );
        },
      ),
    );
  }
}
