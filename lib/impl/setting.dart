import 'package:flutter/material.dart';

import '../bloc/app_setting_bloc.dart';
import '../util/color.dart';
import 'db.dart';

class SettingImpl {
  static final SettingImpl _instance = SettingImpl._internal();

  SettingImpl._internal({
    this.themeMode = ThemeMode.system,
    this.themeColor = ThemeColor.SYSTEM,
    this.language = 'zh',
    this.firstLanuch = true,
  });

  static SettingImpl get instance => _instance;

  ThemeMode themeMode;
  ThemeColor themeColor;
  String language;
  bool firstLanuch;

  Future<void> init() async {
    await getSettings();
  }

  Future<AppSettingState> getSettings() async {
    language = Db.get(DbKey.language, 'zh');
    themeMode = Db.get(DbKey.themeMode, ThemeMode.system) as ThemeMode;
    themeColor = Db.get(DbKey.themeColor, ThemeColor.SYSTEM) as ThemeColor;
    firstLanuch = Db.get(DbKey.firstLanuch, true);

    final settingState = AppSettingState(
      themeMode: themeMode,
      themeColor: themeColor,
      language: language,
    );
    return settingState;
  }

  void saveThemeMode(ThemeMode themeMode) {
    this.themeMode = themeMode;
    setSetting(DbKey.themeMode, themeMode);
  }

  void saveThemeColor(ThemeColor themeColor) {
    this.themeColor = themeColor;
    setSetting(DbKey.themeColor, themeColor);
  }

  void saveLanguage(String language) {
    this.language = language;
    setSetting(DbKey.language, language);
  }

  void saveFirstLanuch({required bool firstLanuch}) {
    this.firstLanuch = firstLanuch;
    setSetting(DbKey.firstLanuch, firstLanuch);
  }

  void setSetting<T>(DbKey<T> key, T value) {
    switch (key) {
      case DbKey.themeMode:
        themeMode = value as ThemeMode;
        break;
      case DbKey.themeColor:
        themeColor = value as ThemeColor;
        break;
      case DbKey.language:
        language = value as String;
        break;
      case DbKey.assetETag:
        // TODO: Handle this case.
        break;
      case DbKey.deviceIdHash:
        // TODO: Handle this case.
        break;
      case DbKey.deviceId:
        // TODO: Handle this case.
        break;
      case DbKey.version:
        // TODO: Handle this case.
        break;
      case DbKey.firstLanuch:
        // TODO: Handle this case.
        break;
    }
    Db.put(key, value);
  }
}
