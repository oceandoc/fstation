import 'dart:ui';

import 'package:flutter/material.dart';

import '../bloc/app_setting_bloc.dart';
import '../model/settings.dart';
import 'store.dart';

class SettingImpl {
  SettingImpl._internal();

  static final SettingImpl _instance = SettingImpl._internal();

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
    await Store.instance.saveSettings(_settings!);
  }

  Future<void> saveLanguage(String language) async {
    _settings = settings.copyWith(language: language);
    await Store.instance.saveSettings(_settings!);
  }

  Future<void> saveWindowsPosition(List<int> position) async {
    _settings = settings.copyWith(windowsPosition: position);
    await Store.instance.saveSettings(_settings!);
  }

  List<int>? get windowsPosition {
    return settings.windowsPosition; // Directly return the list
  }

  Future<void> saveWindowsAlwaysOnTop({required bool alwaysOnTop}) async {
    _settings = settings.copyWith(windowsAlwaysOnTop: alwaysOnTop);
    await Store.instance.saveSettings(_settings!);
  }

  bool get windowsAlwaysOnTop => settings.windowsAlwaysOnTop;

  Future<void> saveLogLevel(int logLevel) async {
    _settings = settings.copyWith(logLevel: logLevel);
    await Store.instance.saveSettings(_settings!);
  }

  Future<void> saveLogFileSize(int logFileSize) async {
    _settings = settings.copyWith(logFileSize: logFileSize);
    await Store.instance.saveSettings(_settings!);
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

    await Store.instance.saveSettings(_settings!);
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

    await Store.instance.saveSettings(_settings!);
  }

  Future<void> saveFirstLaunch({required bool firstLaunch}) async {
    _settings = settings.copyWith(firstLaunch: firstLaunch);
    await Store.instance.saveSettings(_settings!);
  }

  Future<void> saveEnableFingerprint({required bool enable}) async {
    _settings = settings.copyWith(enableFingerprint: enable);
    await Store.instance.saveSettings(_settings!);
  }

  Future<void> saveEnablePin({required bool enable}) async {
    _settings = settings.copyWith(enablePin: enable);
    await Store.instance.saveSettings(_settings!);
  }

  Future<void> saveServerAddr(String serverAddr) async {
    _settings = settings.copyWith(serverAddr: serverAddr);
    await Store.instance.saveSettings(_settings!);
  }

  String get serverAddr => settings.serverAddr;

  // Getters for commonly used values
  ThemeMode get themeMode => ThemeMode.values[settings.themeMode];

  String get language => settings.language;

  bool get firstLaunch => settings.firstLaunch;

  bool get enableFingerprint => settings.enableFingerprint;

  bool get enablePin => settings.enablePin;

  String get serverUuid => settings.serverUuid;

  Future<void> saveServerUuid(String uuid) async {
    _settings = settings.copyWith(serverUuid: uuid);
    await Store.instance.saveSettings(_settings!);
  }

  // Get server repository UUIDs
  List<String> get serverRepoUuids => settings.serverRepoUuids;

  // Save server repository UUIDs
  Future<void> saveServerRepoUuids(List<String> uuids) async {
    _settings = settings.copyWith(serverRepoUuids: uuids);
    await Store.instance.saveSettings(_settings!);
  }

  // Add a single UUID to the list
  Future<void> addServerRepoUuid(String uuid) async {
    if (!settings.serverRepoUuids.contains(uuid)) {
      final updatedUuids = List<String>.from(settings.serverRepoUuids)
        ..add(uuid);
      await saveServerRepoUuids(updatedUuids);
    }
  }

  // Remove a single UUID from the list
  Future<void> removeServerRepoUuid(String uuid) async {
    if (settings.serverRepoUuids.contains(uuid)) {
      final updatedUuids = List<String>.from(settings.serverRepoUuids)
        ..remove(uuid);
      await saveServerRepoUuids(updatedUuids);
    }
  }

  List<String> get selectedAlbums => settings.selectedAlbums;

  Future<void> saveSelectedAlbums(List<String> albums) async {
    _settings = settings.copyWith(selectedAlbums: albums);
    await Store.instance.saveSettings(_settings!);
  }
}
