import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../generated/l10n.dart';

String themeModeName(ThemeMode mode) {
  switch (mode) {
    case ThemeMode.dark:
      return Localization.current.theme_setting_dark_mode_dark;
    case ThemeMode.light:
      return Localization.current.theme_setting_dark_mode_light;
    case ThemeMode.system:
      return Localization.current.theme_setting_dark_mode_system;
  }
}

void showToast(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.pinkAccent,
      textColor: Colors.white,
      fontSize: 16);
}

Locale getLocale(String code) {
  final locale = Locale.fromSubtags(languageCode: code);
  if (Localization.delegate.isSupported(locale)) {
    return locale;
  }
  return Localization.delegate.supportedLocales.first;
}

String getLocaleName(Locale local) {
  if (local.languageCode == 'en') {
    return 'English';
  } else if (local.languageCode == 'zh') {
    return '中文';
  }
  return 'English';
}
