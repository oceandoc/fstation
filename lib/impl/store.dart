import 'package:fstation/impl/logger.dart';
import 'package:sqflite/sqflite.dart';

import '../util/constants.dart';
import '../model/settings.dart';

class Store {
  // Private constructor
  Store._internal();

  // Singleton instance
  static final Store _instance = Store._internal();

  // Factory constructor to return the same instance
  factory Store() => _instance;

  // Make this static to easily access the instance
  static Store get instance => _instance;

  var _db;

  Future<bool> init() async {
    _db = await databaseFactory.openDatabase(
      'fstation.db',
      options: OpenDatabaseOptions(
        version: kCurrentDBVersion,
        onUpgrade: (Database db, int oldVersion, int newVersion) async {
          try {
            await migrate(db, oldVersion, newVersion);
          } catch (e, stack) {
            Logger.error('upgrade database error', e, stack);
          }
        },
        onCreate: initDatabase,
        onOpen: (db) {
          Logger.info('database path：${db.path}');
        },
      ),
    );
    return true;
  }

  /// 执行数据库迁移
  Future<void> migrate(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 1) {
      initDatabase(db, newVersion);
    }
  }

  /// 数据库初始化
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
    final List<Map<String, dynamic>> maps =
        await _db.query('settings') as List<Map<String, dynamic>>;
    if (maps.isEmpty) {
      return null;
    }
    return Settings.fromMap(maps.first);
  }

  Future<void> saveSettings(Settings settings) async {
    if (settings.id != null) {
      await _db.update(
        'settings',
        settings.toMap(),
        where: 'id = ?',
        whereArgs: [settings.id],
      );
    } else {
      await _db.insert('settings', settings.toMap());
    }
  }

  Future<void> updateSettings(Map<String, dynamic> values) async {
    final settings = await getSettings();
    if (settings == null) {
      await saveSettings(Settings.fromMap(values));
    } else {
      await _db.update(
        'settings',
        values,
        where: 'id = ?',
        whereArgs: [settings.id],
      );
    }
  }
}
