import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart' as log;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class Logger {
  Logger._internal() {
    _logger = log.Logger('AppLogger');
  }

  static final Logger _instance = Logger._internal();

  static Logger get instance => _instance;

  late final log.Logger _logger;
  File? _logFile;
  late int _maxSizeInBytes;
  final int maxLogFiles = 7;
  int logCount = 0;
  final int checkInterval = 100;
  bool _initialized = false;

  String? get appLogPath => _logFile?.path;

  Future<String> get logDirectory async {
    final directory = await getApplicationDocumentsDirectory();
    return path.join(directory.path, 'logs');
  }

  Future<void> init([int maxSizeInBytes = 100 * 1024 * 1024]) async {
    if (_initialized) return;
    print('Logger init called');

    _instance._maxSizeInBytes = maxSizeInBytes;
    if (kDebugMode) {
      log.Logger.root.level = log.Level.ALL;
      log.Logger.root.onRecord.listen((record) async {
        final logMessage =
            '${record.time}: [${record.level.name}] ${record.loggerName} ${record.sequenceNumber} ${record.object ?? ''} - ${record.message}';
        print(logMessage);
      });
    } else {
      print('release');
      final directory = await getApplicationDocumentsDirectory();
      final logsDir = path.join(directory.path, 'logs');
      // Create logs directory if it doesn't exist
      if (!Directory(logsDir).existsSync()) {
        await Directory(logsDir).create(recursive: true);
      }
      _logFile = File(path.join(logsDir, 'app.log'));
      log.Logger.root.level = log.Level.SEVERE;
      log.Logger.root.onRecord.listen((record) async {
        final logMessage =
            '${record.time}: [${record.level.name}] ${record.loggerName} - ${record.message}';
        _logFile?.writeAsStringSync('$logMessage\n', mode: FileMode.append);
        logCount++;
        if (logCount >= checkInterval) {
          logCount = 0;
          await _manageLogFileSize(logsDir);
        }
      });
    }
    _initialized = true;
  }

  Future<void> _manageLogFileSize(String directory) async {
    if (_logFile != null && await _logFile!.length() > _maxSizeInBytes) {
      final newPath =
          '$directory/app.log.${DateTime.now().millisecondsSinceEpoch}';
      await _logFile!.rename(newPath);
      _logFile = File('$directory/app.log');

      final logFiles = Directory(directory)
          .listSync()
          .where((file) => file.path.contains('app.log.'))
          .toList()
        ..sort(
            (a, b) => a.statSync().modified.compareTo(b.statSync().modified));

      while (logFiles.length > maxLogFiles) {
        try {
          final oldestFile = logFiles.removeAt(0);
          await File(oldestFile.path).delete();
        } catch (e) {
          if (kDebugMode) {
            print('Error deleting log file: $e');
          }
        }
      }
    }
  }

  // Static methods for logging with consistent format
  static void info(String message, [Object? error, StackTrace? stackTrace]) {
    if (!_instance._initialized) {
      print('WARNING: Logger not initialized when logging: $message');
      return;
    }
    _instance._logger.info(message, error, stackTrace);
  }

  static void debug(String message, [Object? error, StackTrace? stackTrace]) {
    if (!_instance._initialized) {
      print('WARNING: Logger not initialized when logging: $message');
      return;
    }
    _instance._logger.fine(message, error, stackTrace);
  }

  static void warning(String message, [Object? error, StackTrace? stackTrace]) {
    _instance._logger.warning(message, error, stackTrace);
  }

  static void error(String message, [Object? error, StackTrace? stackTrace]) {
    _instance._logger.severe(message, error, stackTrace);
  }

  static void verbose(String message, [Object? error, StackTrace? stackTrace]) {
    _instance._logger.finer(message, error, stackTrace);
  }
}

// Add helper class for file position
class _FilePosition {
  final String file;
  final int line;
  _FilePosition(this.file, this.line);
}
