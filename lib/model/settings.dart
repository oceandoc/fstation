class Settings {
  int? id;
  int notificationBackgroundBackupProgress;
  int notificationBackgroundBackupFailNotifyTime;
  String language;
  int themeMode;
  int logLevel;
  int logFileSize;
  String? proxyHost;
  int proxyPort;
  String? proxyUsername;
  String? proxyPassword;
  int autoUpdateCheckTime;
  bool firstLaunch;

  Settings({
    this.id,
    this.notificationBackgroundBackupProgress = 0,
    this.notificationBackgroundBackupFailNotifyTime = 120,
    this.language = 'en',
    this.themeMode = 0,
    this.logLevel = 0,
    this.logFileSize = 100,
    this.proxyHost,
    this.proxyPort = 0,
    this.proxyUsername,
    this.proxyPassword,
    this.autoUpdateCheckTime = 0,
    this.firstLaunch = true,
  });

  // Create Settings from JSON/Map
  factory Settings.fromMap(Map<String, dynamic> map) {
    return Settings(
      id: map['id'] as int?,
      notificationBackgroundBackupProgress:
          map['notification_background_backup_progress'] as int? ?? 0,
      notificationBackgroundBackupFailNotifyTime:
          map['notification_background_backup_fail_notify_time'] as int? ?? 120,
      language: map['language'] as String? ?? 'en',
      themeMode: map['theme_mode'] as int? ?? 0,
      logLevel: map['log_level'] as int? ?? 0,
      logFileSize: map['log_file_size'] as int? ?? 100,
      proxyHost: map['proxy_host'] as String?,
      proxyPort: map['proxy_port'] as int? ?? 0,
      proxyUsername: map['proxy_username'] as String?,
      proxyPassword: map['proxy_password'] as String?,
      autoUpdateCheckTime: map['auto_update_check_time'] as int? ?? 0,
      firstLaunch: (map['first_launch'] as int? ?? 1) == 1,
    );
  }

  // Convert Settings to JSON/Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'notification_background_backup_progress':
          notificationBackgroundBackupProgress,
      'notification_background_backup_fail_notify_time':
          notificationBackgroundBackupFailNotifyTime,
      'language': language,
      'theme_mode': themeMode,
      'log_level': logLevel,
      'log_file_size': logFileSize,
      'proxy_host': proxyHost,
      'proxy_port': proxyPort,
      'proxy_username': proxyUsername,
      'proxy_password': proxyPassword,
      'auto_update_check_time': autoUpdateCheckTime,
      'first_launch': firstLaunch ? 1 : 0,
    };
  }

  // Create a copy of Settings with some fields updated
  Settings copyWith({
    int? id,
    int? notificationBackgroundBackupProgress,
    int? notificationBackgroundBackupFailNotifyTime,
    String? language,
    int? themeMode,
    int? logLevel,
    int? logFileSize,
    String? proxyHost,
    int? proxyPort,
    String? proxyUsername,
    String? proxyPassword,
    int? autoUpdateCheckTime,
    bool? firstLaunch,
  }) {
    return Settings(
      id: id ?? this.id,
      notificationBackgroundBackupProgress:
          notificationBackgroundBackupProgress ??
              this.notificationBackgroundBackupProgress,
      notificationBackgroundBackupFailNotifyTime:
          notificationBackgroundBackupFailNotifyTime ??
              this.notificationBackgroundBackupFailNotifyTime,
      language: language ?? this.language,
      themeMode: themeMode ?? this.themeMode,
      logLevel: logLevel ?? this.logLevel,
      logFileSize: logFileSize ?? this.logFileSize,
      proxyHost: proxyHost ?? this.proxyHost,
      proxyPort: proxyPort ?? this.proxyPort,
      proxyUsername: proxyUsername ?? this.proxyUsername,
      proxyPassword: proxyPassword ?? this.proxyPassword,
      autoUpdateCheckTime: autoUpdateCheckTime ?? this.autoUpdateCheckTime,
      firstLaunch: firstLaunch ?? this.firstLaunch,
    );
  }

  @override
  String toString() {
    return 'Settings{id: $id, language: $language, themeMode: $themeMode, ...}';
  }
}
