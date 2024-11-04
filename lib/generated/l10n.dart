// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class Localization {
  Localization();

  static Localization? _current;

  static Localization get current {
    assert(_current != null,
        'No instance of Localization was loaded. Try to initialize the Localization delegate before accessing Localization.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<Localization> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = Localization();
      Localization._current = instance;

      return instance;
    });
  }

  static Localization of(BuildContext context) {
    final instance = Localization.maybeOf(context);
    assert(instance != null,
        'No instance of Localization present in the widget tree. Did you add Localization.delegate in localizationsDelegates?');
    return instance!;
  }

  static Localization? maybeOf(BuildContext context) {
    return Localizations.of<Localization>(context, Localization);
  }

  /// `English`
  String get language {
    return Intl.message(
      'English',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get language_en {
    return Intl.message(
      'English',
      name: 'language_en',
      desc: '',
      args: [],
    );
  }

  /// `About`
  String get about_app {
    return Intl.message(
      'About',
      name: 'about_app',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language_setting_title {
    return Intl.message(
      'Language',
      name: 'language_setting_title',
      desc: '',
      args: [],
    );
  }

  /// `主题`
  String get theme_setting_theme_title {
    return Intl.message(
      '主题',
      name: 'theme_setting_theme_title',
      desc: '',
      args: [],
    );
  }

  /// `Dark mode`
  String get theme_setting_dark_mode {
    return Intl.message(
      'Dark mode',
      name: 'theme_setting_dark_mode',
      desc: '',
      args: [],
    );
  }

  /// `Dark`
  String get theme_setting_dark_mode_dark {
    return Intl.message(
      'Dark',
      name: 'theme_setting_dark_mode_dark',
      desc: '',
      args: [],
    );
  }

  /// `Light`
  String get theme_setting_dark_mode_light {
    return Intl.message(
      'Light',
      name: 'theme_setting_dark_mode_light',
      desc: '',
      args: [],
    );
  }

  /// `System`
  String get theme_setting_dark_mode_system {
    return Intl.message(
      'System',
      name: 'theme_setting_dark_mode_system',
      desc: '',
      args: [],
    );
  }

  /// `Primary color`
  String get theme_setting_primary_color_title {
    return Intl.message(
      'Primary color',
      name: 'theme_setting_primary_color_title',
      desc: '',
      args: [],
    );
  }

  /// `Use system color`
  String get theme_setting_system_primary_color_title {
    return Intl.message(
      'Use system color',
      name: 'theme_setting_system_primary_color_title',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<Localization> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'zh'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<Localization> load(Locale locale) => Localization.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
