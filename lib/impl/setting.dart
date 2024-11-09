import 'package:flutter/material.dart';
import 'dart:ui'; // Import to access system locale

import '../bloc/app_setting_bloc.dart';
import 'db.dart';

class SettingImpl {
  static final SettingImpl _instance = SettingImpl._internal();

  SettingImpl._internal({
    this.themeMode = ThemeMode.system,
    String? language, // Make language nullable
    this.firstLanuch = true,
  }) : language = language ??
            WidgetsBinding.instance.platformDispatcher.locale
                .languageCode; // Initialize in constructor body

  static SettingImpl get instance => _instance;

  ThemeMode themeMode;
  String language;
  bool firstLanuch;

  Future<void> init() async {
    await getSettings();
  }

  Future<AppSettingState> getSettings() async {
    language = Db.get(
        DbKey.language,
        PlatformDispatcher
            .instance.locale.languageCode); // Default to system locale
    themeMode = Db.get(DbKey.themeMode, ThemeMode.system) as ThemeMode;
    firstLanuch = Db.get(DbKey.firstLanuch, true);

    final settingState = AppSettingState(
      themeMode: themeMode,
      language: language,
    );
    return settingState;
  }

  void saveThemeMode(ThemeMode themeMode) {
    this.themeMode = themeMode;
    setSetting(DbKey.themeMode, themeMode);
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
      case DbKey.themeColor:
      // TODO: support color
      case DbKey.language:
        language = value as String;
      case DbKey.assetETag:
      // TODO: Handle this case.
      case DbKey.deviceIdHash:
      // TODO: Handle this case.
      case DbKey.deviceId:
      // TODO: Handle this case.
      case DbKey.version:
      // TODO: Handle this case.
      case DbKey.firstLanuch:
      // TODO: Handle this case.
    }
    Db.put(key, value);
  }
}
