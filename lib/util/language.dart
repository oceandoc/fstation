import 'package:flutter/material.dart';
import 'package:fstation/util/extensions.dart';
import 'package:intl/intl.dart';

class Language {

  const Language(this.code, this.name, this.nameEn, this.country, this.locale);

  final String code;
  final String name;
  final String nameEn;
  final String country;
  final Locale locale;

  static const List<Language> supportLanguages = [
    Language('en', 'English', 'English', 'United States', Locale('en', 'US')),
    Language('zh', '简体中文', 'Simplified Chinese', '中国大陆', Locale('zh', 'CN')),
    // Language('zh', '简体中文', 'Simplified Chinese', Locale('zh', 'Hans')),
    // Language('zh', '繁体中文', 'Traditional Chinese', Locale('zh', 'Hant')),
    // Language('zh', '简体中文', 'Simplified Chinese', Locale('zh', 'SG')),
  ];

  static List<Language> getSortedSupportedLanguage() {
    return supportLanguages;
  }

  static Language getLanguage(String? code) {
    final localCode = Intl.canonicalizedLocale(code ??  systemLocale.toString());
    return supportLanguages
        .firstWhereOrNull((lang) => localCode.startsWith(lang.code)) ?? supportLanguages.first;
  }

  static Locale get systemLocale =>
      WidgetsBinding.instance.platformDispatcher.locale;

  @override
  String toString() {
    return "Language('$code', '$name')";
  }
}
