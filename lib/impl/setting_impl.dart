import 'package:flutter/material.dart';
import 'dart:ui';

import '../bloc/app_setting_bloc.dart';
import '../model/settings.dart';
import 'store.dart';

class SettingImpl {
  static final SettingImpl _instance = SettingImpl._internal();

  SettingImpl._internal();

  static SettingImpl get instance => _instance;

  Settings? _settings;

  Settings get settings =>
      _settings ??
      Settings(
        language: PlatformDispatcher.instance.locale.languageCode,
      );

  Future<void> init() async {
    await getSettings();
  }

  Future<AppSettingState> getSettings() async {
    _settings = await Store.instance.getSettings();

    if (_settings == null) {
      _settings = Settings(
        themeMode: ThemeMode.system.index,
        language: PlatformDispatcher.instance.locale.languageCode,
        firstLaunch: true,
      );
      await Store.instance.saveSettings(_settings!);
    }

    return AppSettingState(
      themeMode: ThemeMode.values[settings.themeMode],
      language: settings.language,
    );
  }

  Future<void> saveThemeMode(ThemeMode themeMode) async {
    _settings = settings.copyWith(themeMode: themeMode.index);
    await Store.instance.updateSettings({
      'theme_mode': themeMode.index,
    });
  }

  Future<void> saveLanguage(String language) async {
    _settings = settings.copyWith(language: language);
    await Store.instance.updateSettings({
      'language': language,
    });
  }

  Future<void> saveLogLevel(int logLevel) async {
    _settings = settings.copyWith(logLevel: logLevel);
    await Store.instance.updateSettings({
      'log_level': logLevel,
    });
  }

  Future<void> saveLogFileSize(int logFileSize) async {
    _settings = settings.copyWith(logFileSize: logFileSize);
    await Store.instance.updateSettings({
      'log_file_size': logFileSize,
    });
  }

  Future<void> saveProxySettings({
    String? host,
    int? port,
    String? username,
    String? password,
  }) async {
    final updates = <String, dynamic>{};
    if (host != null) updates['proxy_host'] = host;
    if (port != null) updates['proxy_port'] = port;
    if (username != null) updates['proxy_username'] = username;
    if (password != null) updates['proxy_password'] = password;

    _settings = settings.copyWith(
      proxyHost: host ?? settings.proxyHost,
      proxyPort: port ?? settings.proxyPort,
      proxyUsername: username ?? settings.proxyUsername,
      proxyPassword: password ?? settings.proxyPassword,
    );

    await Store.instance.updateSettings(updates);
  }

  Future<void> saveNotificationSettings({
    int? backupProgress,
    int? failNotifyTime,
  }) async {
    final updates = <String, dynamic>{};
    if (backupProgress != null) {
      updates['notification_background_backup_progress'] = backupProgress;
    }
    if (failNotifyTime != null) {
      updates['notification_background_backup_fail_notify_time'] =
          failNotifyTime;
    }

    _settings = settings.copyWith(
      notificationBackgroundBackupProgress:
          backupProgress ?? settings.notificationBackgroundBackupProgress,
      notificationBackgroundBackupFailNotifyTime:
          failNotifyTime ?? settings.notificationBackgroundBackupFailNotifyTime,
    );

    await Store.instance.updateSettings(updates);
  }

  Future<void> saveFirstLaunch(bool value) async {
    _settings = settings.copyWith(firstLaunch: value);
    await Store.instance.updateSettings({
      'first_launch': value ? 1 : 0,
    });
  }

  // Getters for commonly used values
  ThemeMode get themeMode => ThemeMode.values[settings.themeMode];
  String get language => settings.language;
  bool get firstLaunch => settings.firstLaunch;
}
