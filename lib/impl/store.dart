import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:fstation/impl/logger.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

import '../model/settings.dart';

class Store {
  Store._internal();

  static final Store _instance = Store._internal();

  static Store get instance => _instance;

  static const kCurrentDBVersion = 1;
  late final Database _db;

  Future<bool> init() async {
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
    if (oldVersion < 2) {}
    // Add future version upgrades here
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
          first_launch INTEGER DEFAULT 1,
          windows_position TEXT,
          windows_always_ontop INTEGER DEFAULT 0,
          enable_fingerprint INTEGER DEFAULT 0,
          enable_pin INTEGER DEFAULT 0
        )
      ''');

    // Insert a default settings record
    await db.insert('settings', {
      'notification_background_backup_progress': 0,
      'notification_background_backup_fail_notify_time': 120,
      'language': 'en',
      'theme_mode': 0,
      'log_level': 0,
      'log_file_size': 100,
      'proxy_host': null,
      'proxy_port': 0,
      'proxy_username': null,
      'proxy_password': null,
      'auto_update_check_time': 0,
      'first_launch': 1,
      'windows_position': null,
      'windows_always_ontop': 0,
      'enable_fingerprint': 0,
      'enable_pin': 0
    });

    await db.execute('''
        CREATE TABLE user (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT UNIQUE,
          token TEXT,
          token_update_time TEXT
        )
      ''');

    await db.execute('''
        CREATE TABLE current_user (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          user_name TEXT
        )
      ''');

    await db.execute('''
        CREATE TABLE app_info (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          uuid TEXT
        )
      ''');

    // Insert default users after table creation
    await db.insert('user', {
      'id': 0,
      'name': 'admin',
      'token': '',
      'token_update_time': DateTime.now().toIso8601String(),
    });

    await db.insert('user', {
      'id': 1,
      'name': 'guest',
      'token': '',
      'token_update_time': DateTime.now().toIso8601String(),
    });
  }

  Future<Settings?> getSettings() async {
    final maps = await _db.query('settings') as List<Map<String, dynamic>>;
    if (maps.isEmpty) {
      return null;
    }
    return Settings.fromMap(maps.first);
  }

  Future<void> saveSettings(Settings settings) async {
    final existingSettings = await getSettings();
    if (existingSettings == null) {
      await _db.insert('settings', settings.toMap());
    } else {
      await _db.update(
        'settings',
        settings.toMap(),
        where: 'id = ?',
        whereArgs: [existingSettings.id],
      );
    }
  }

  Future<void> addUser({
    required String name,
    required String token,
    String? tokenUpdateTime,
  }) async {
    await _db.insert('user', {
      'name': name,
      'token': token,
      'token_update_time': tokenUpdateTime ?? DateTime.now().toIso8601String(),
    });
  }

  Future<void> updateUser({
    required String name,
    String? token,
    String? tokenUpdateTime,
  }) async {
    final values = <String, dynamic>{'name': name};
    if (token != null) values['token'] = token;
    if (tokenUpdateTime != null) values['token_update_time'] = tokenUpdateTime;

    await _db.update(
      'user',
      values,
      where: 'name = ?',
      whereArgs: [name],
    );
  }

  Future<void> deleteUser(String name) async {
    await _db.delete(
      'user',
      where: 'name = ?',
      whereArgs: [name],
    );
  }

  Future<Map<String, dynamic>?> getUser(String name) async {
    final result = await _db.query(
      'user',
      where: 'name = ?',
      whereArgs: [name],
      limit: 1,
    );
    return result.isNotEmpty ? result.first : null;
  }

  Future<void> setCurrentUser(String name) async {
    await _db.insert(
      'current_user',
      {'id': 1, 'user_name': name},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Map<String, dynamic>?> getCurrentUser() async {
    final currentUserResult = await _db.query(
      'current_user',
      where: 'id = 1',
      limit: 1,
    );
    if (currentUserResult.isEmpty) return null;

    final userName = currentUserResult.first['user_name']! as String;
    return getUser(userName);
  }

  Future<void> deleteCurrentUser() async {
    await _db.delete(
      'current_user',
      where: 'id = 1',
    );
  }

  Future<String> getUuid() async {
    final result = await _db.query(
      'app_info',
      columns: ['uuid'],
      limit: 1,
    );
    return result.isNotEmpty ? result.first['uuid']! as String : '';
  }

  Future<void> setUuid(String uuid) async {
    await _db.insert(
      'app_info',
      {'uuid': uuid},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
