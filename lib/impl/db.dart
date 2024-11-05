import 'package:collection/collection.dart';
import 'package:isar/isar.dart';
import 'package:logging/logging.dart';

part 'db.g.dart';

enum DbKey<T> {
  version<int>(0, type: int),
  assetETag<String>(1, type: String),
  deviceIdHash<int>(3, type: int),
  deviceId<String>(4, type: String),
  themeMode<int>(5, type: int),
  themeColor<int>(6, type: int),
  language<String>(7, type: String),
  firstLanuch<bool>(8, type: bool),
  ;

  const DbKey(
    this.id, {
    required this.type,
    this.fromDb,
    this.toDb,
  });

  final int id;
  final Type type;
  final T? Function<T>(Isar, int)? fromDb;
  final Future<int> Function<T>(Isar, T)? toDb;
}

/// Internal class for `Store`, do not use elsewhere.
@Collection(inheritance: false)
class DbValue {
  DbValue(this.id, {this.intValue, this.strValue});

  Id id;
  int? intValue;
  String? strValue;

  T? _extract<T>(DbKey<T> key) {
    switch (key.type) {
      case const (int):
        return intValue as T?;
      case const (bool):
        return intValue == null ? null : (intValue! == 1) as T;
      case const (DateTime):
        return intValue == null
            ? null
            : DateTime.fromMicrosecondsSinceEpoch(intValue!) as T;
      case const (String):
        return strValue as T?;
      default:
        if (key.fromDb != null) {
          return key.fromDb!.call(Db._db, intValue!);
        }
    }
    throw TypeError();
  }

  static Future<DbValue> _of<T>(T? value, DbKey<T> key) async {
    int? i;
    String? s;
    switch (key.type) {
      case const (int):
        i = value as int?;
      case const (bool):
        i = value == null ? null : (value == true ? 1 : 0);
      case const (DateTime):
        i = value == null ? null : (value as DateTime).microsecondsSinceEpoch;
      case const (String):
        s = value as String?;
      default:
        if (key.toDb != null) {
          i = await key.toDb!.call(Db._db, value);
          break;
        }
        throw TypeError();
    }
    return DbValue(key.id, intValue: i, strValue: s);
  }
}

class DbKeyNotFoundException implements Exception {
  DbKeyNotFoundException(this.key);
  final DbKey key;
  @override
  String toString() => "Key '${key.name}' not found in Store";
}

class Db {
  static final Logger _log = Logger('Db');
  static late final Isar _db;
  static final List<dynamic> _cache =
      List.filled(DbKey.values.map((e) => e.id).max + 1, null);

  /// Initializes the store (call exactly once per app start)
  static void init(Isar db) {
    _db = db;
    _populateCache();
    _db.dbValues.where().build().watch().listen(_onChangeListener);
  }

  /// clears all values from this store (cache and DB), only for testing!
  static Future<void> clear() {
    _cache.fillRange(0, _cache.length, null);
    return _db.writeTxn(() => _db.dbValues.clear());
  }

  static bool firstLanuch() {
    return get(DbKey.firstLanuch, true);
  }

  static T get<T>(DbKey<T> key, [T? defaultValue]) {
    final value = _cache[key.id] ?? defaultValue;
    if (value == null) {
      throw DbKeyNotFoundException(key);
    }
    return value as T;
  }

  /// Watches a specific key for changes
  static Stream<T?> watch<T>(DbKey<T> key) =>
      _db.dbValues.watchObject(key.id).map((e) => e?._extract(key));

  static T? tryGet<T>(DbKey<T> key) {
    final value = _cache[key.id];
    return value as T?;
  }

  /// Stores the value synchronously in the cache and asynchronously in the DB
  static Future<void> put<T>(DbKey<T> key, T value) {
    if (_cache[key.id] == value) return Future.value();
    _cache[key.id] = value;
    return _db.writeTxn(
      () async => _db.dbValues.put(await DbValue._of(value, key)),
    );
  }

  /// Removes the value synchronously from the cache and asynchronously from the DB
  static Future<void> delete<T>(DbKey<T> key) {
    if (_cache[key.id] == null) return Future.value();
    _cache[key.id] = null;
    return _db.writeTxn(() => _db.dbValues.delete(key.id));
  }

  /// Fills the cache with the values from the DB
  static void _populateCache() {
    for (final key in DbKey.values) {
      final value = _db.dbValues.getSync(key.id);
      if (value != null) {
        _cache[key.id] = value._extract(key);
      }
    }
  }

  /// updates the state if a value is updated in any isolate
  static void _onChangeListener(List<DbValue>? data) {
    if (data != null) {
      for (final value in data) {
        final key = DbKey.values.firstWhereOrNull((e) => e.id == value.id);
        if (key != null) {
          _cache[value.id] = value._extract(key);
        } else {
          _log.warning('No key available for value id - ${value.id}');
        }
      }
    }
  }
}
