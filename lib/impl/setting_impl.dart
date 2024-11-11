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
    language = Store.get(
        StoreKey.language,
        PlatformDispatcher
            .instance.locale.languageCode); // Default to system locale
    themeMode = Store.get(StoreKey.themeMode, ThemeMode.system) as ThemeMode;
    firstLanuch = Store.get(StoreKey.firstLanuch, true);

    final settingState = AppSettingState(
      themeMode: themeMode,
      language: language,
    );
    return settingState;
  }

  void saveThemeMode(ThemeMode themeMode) {
    this.themeMode = themeMode;
    setSetting(StoreKey.themeMode, themeMode);
  }

  void saveLanguage(String language) {
    this.language = language;
    setSetting(StoreKey.language, language);
  }

  void saveFirstLanuch({required bool firstLanuch}) {
    this.firstLanuch = firstLanuch;
    setSetting(StoreKey.firstLanuch, firstLanuch);
  }

  void setSetting<T>(StoreKey<T> key, T value) {
    switch (key) {
      case StoreKey.themeMode:
        themeMode = value as ThemeMode;
      case StoreKey.themeColor:
      // TODO: support color
      case StoreKey.language:
        language = value as String;
      case StoreKey.assetETag:
      // TODO: Handle this case.
      case StoreKey.deviceIdHash:
      // TODO: Handle this case.
      case StoreKey.deviceId:
      // TODO: Handle this case.
      case StoreKey.version:
      // TODO: Handle this case.
      case StoreKey.firstLanuch:
      // TODO: Handle this case.
    }
    Store.put(key, value);
  }
}
