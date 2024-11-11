import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart' as log;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class Logger {
  // Factory constructor to return the same instance
  factory Logger([int maxSizeInBytes = 100 * 1024 * 1024]) {
    _instance._maxSizeInBytes = maxSizeInBytes;
    return _instance;
  }

  // Private constructor
  Logger._internal() {
    _logger = log.Logger('AppLogger');
    _setupLogging();
  }

  // Singleton instance
  static final Logger _instance = Logger._internal();

  // Static getter for easy access
  static Logger get instance => _instance;

  late final log.Logger _logger;
  File? _logFile;
  late int _maxSizeInBytes;
  final int maxLogFiles = 7;
  int logCount = 0;
  final int checkInterval = 100;

  /// Get the path to the current app log file
  String? get appLogPath => _logFile?.path;

  /// Get the directory containing log files
  Future<String> get logDirectory async {
    final directory = await getApplicationDocumentsDirectory();
    return path.join(directory.path, 'logs');
  }

  Future<void> _setupLogging() async {
    log.Logger.root.level = kReleaseMode ? log.Level.SEVERE : log.Level.ALL;

    final directory = await getApplicationDocumentsDirectory();
    final logsDir = path.join(directory.path, 'logs');

    // Create logs directory if it doesn't exist
    if (!Directory(logsDir).existsSync()) {
      await Directory(logsDir).create(recursive: true);
    }

    _logFile = File(path.join(logsDir, 'app.log'));

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
  static void info(String message, [Object? error, Object? stackTrace]) {
    if (stackTrace is StackTrace) {
      _instance._logger.info(message, error, stackTrace);
    } else {
      _instance._logger.info(message, error);
    }
  }

  static void debug(String message, [Object? error, StackTrace? stackTrace]) {
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
