import 'dart:io' show Directory, Platform;

import 'package:path_provider/path_provider.dart';

import '../impl/logger.dart';

class PathHelper {

  factory PathHelper() {
    return _instance;
  }

  PathHelper._internal();
  late final String cachePath;
  late final String documentsPath;
  late final String supportPath;

  Future<void> init() async {
    try {
      cachePath =
          (await getApplicationCacheDirectory()).path.replaceAll(r'\', '/');
    } catch (e) {
      cachePath = '';
    }

    try {
      documentsPath =
          (await getApplicationDocumentsDirectory()).path.replaceAll(r'\', '/');
    } catch (e) {
      documentsPath = '';
    }

    try {
      supportPath =
          (await getApplicationSupportDirectory()).path.replaceAll(r'\', '/');
    } catch (e) {
      supportPath = '';
    }

    try {
      await Directory(getHomePath).create(recursive: true);
    } catch (e) {
      Logger.error('create $getHomePath fail: $e');
    }
  } // init

  String get getHomePath {
    if (Platform.isMacOS || Platform.isLinux) {
      return '${Platform.environment['HOME'] ?? ''}/.fstation';
    } else if (Platform.isWindows) {
      return '${Platform.environment['UserProfile'] ?? ''}/.fstation';
    } else if (Platform.isAndroid || Platform.isIOS) {
      return '$documentsPath/.fstation';
    }
    return '.fstation';
  }

  String get getLogfilePath {
    return '$getHomePath/fstation.log';
  }

  String get getCachePath {
    return '$getHomePath/cache';
  }

  /// 单例
  static final PathHelper _instance = PathHelper._internal();

  Map<String, String> toMap() {
    return {
      'cachePath': cachePath,
      'cachePathReal': getCachePath,
      'documentsPath': documentsPath,
      'supportPath': supportPath,
      'homePath': getHomePath,
      'logfilePath': getLogfilePath,
    };
  }
}
