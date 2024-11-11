import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:fstation/impl/logger.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

import '../model/settings.dart';
import '../util/constants.dart';

class Store {
  // Factory constructor to return the same instance
  factory Store() => _instance;
  // Private constructor
  Store._internal();

  // Singleton instance
  static final Store _instance = Store._internal();

  // Make this static to easily access the instance
  static Store get instance => _instance;

  Database? _db;

  Future<bool> init() async {
    if (_db != null) return true;

    // Initialize appropriate database factory based on platform
    if (kIsWeb) {
      // Web platform
      databaseFactory = databaseFactoryFfiWeb;
      _db = await databaseFactory.openDatabase(
        'fstation.db',
        options: OpenDatabaseOptions(
          version: kCurrentDBVersion,
          onCreate: initDatabase,
          onUpgrade: _onUpgrade,
          onOpen: _onOpen,
        ),
      );
    } else {
      // Desktop and Mobile platforms
      if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
        // Desktop platforms
        sqfliteFfiInit();
        databaseFactory = databaseFactoryFfi;
      }
      // else: Mobile platforms use default databaseFactory

      // Get the database path
      final dbFolder = await getApplicationDocumentsDirectory();
      final dbPath = join(dbFolder.path, 'fstation.db');

      // Set database path for desktop platforms
      if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
        await databaseFactory.setDatabasesPath(dbFolder.path);
      }

      _db = await databaseFactory.openDatabase(
        dbPath,
        options: OpenDatabaseOptions(
          version: kCurrentDBVersion,
          onCreate: initDatabase,
          onUpgrade: _onUpgrade,
          onOpen: _onOpen,
        ),
      );
    }

    return true;
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    try {
      await migrate(db, oldVersion, newVersion);
    } catch (e, stack) {
      Logger.error('upgrade database error', e, stack);
    }
  }

  void _onOpen(Database db) {
    Logger.info('database path: ${db.path}');
  }

  /// Execute database migration
  Future<void> migrate(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 1) {
      await initDatabase(db, newVersion);
    }
  }

  /// Initialize database
  Future<void> initDatabase(Database db, int version) async {
    await db.execute('''
        CREATE TABLE settings (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          notification_background_backup_progress INTEGER DEFAULT 0,
          notification_background_backup_fail_notify_time INTEGER DEFAULT 120,
          language TEXT NOT NULL DEFAULT 'en',
          theme_mode INTEGER DEFAULT 0,
          log_level INTEGER DEFAULT 0,
          log_file_size INTEGER DEFAULT 100,
          proxy_host TEXT,
          proxy_port INTEGER DEFAULT 0,
          proxy_username TEXT,
          proxy_password TEXT,
          auto_update_check_time INTEGER DEFAULT 0,
          first_launch INTEGER DEFAULT 1
        )
      ''');
  }

  Future<Settings?> getSettings() async {
    if (_db == null) await init();

    final maps = await _db!.query('settings') as List<Map<String, dynamic>>;
    if (maps.isEmpty) {
      return null;
    }
    return Settings.fromMap(maps.first);
  }

  Future<void> saveSettings(Settings settings) async {
    if (_db == null) await init();

    if (settings.id != null) {
      await _db!.update(
        'settings',
        settings.toMap(),
        where: 'id = ?',
        whereArgs: [settings.id],
      );
    } else {
      await _db!.insert('settings', settings.toMap());
    }
  }

  Future<void> updateSettings(Map<String, dynamic> values) async {
    if (_db == null) await init();

    final settings = await getSettings();
    if (settings == null) {
      await saveSettings(Settings.fromMap(values));
    } else {
      await _db!.update(
        'settings',
        values,
        where: 'id = ?',
        whereArgs: [settings.id],
      );
    }
  }
}
