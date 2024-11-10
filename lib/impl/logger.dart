import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart' as log;
import 'package:path_provider/path_provider.dart';

class Logger { // Check every 100 log entries

  factory Logger({int maxSizeInBytes = 100 * 1024 * 1024}) {
    _instance.maxSizeInBytes = maxSizeInBytes;
    return _instance;
  }

  Logger._internal() {
    _logger = log.Logger('AppLogger');
    _setupLogging();
  }
  static final Logger _instance = Logger._internal();
  late final log.Logger _logger;
  File? _logFile;
  late final int maxSizeInBytes;
  final int maxLogFiles = 7;
  int logCount = 0;
  final int checkInterval = 100;

  Future<void> _setupLogging() async {
    log.Logger.root.level = kReleaseMode ? log.Level.SEVERE : log.Level.ALL;

    final directory = await getApplicationDocumentsDirectory();
    _logFile = File('${directory.path}/app.log');

    log.Logger.root.onRecord.listen((record) async {
      final logMessage =
          '${record.time}: [${record.level.name}] ${record.loggerName} - ${record.message}';
      _logFile?.writeAsStringSync('$logMessage\n', mode: FileMode.append);

      logCount++;
      if (logCount >= checkInterval) {
        logCount = 0;
        await _manageLogFileSize(directory.path);
      }
    });
  }

  Future<void> _manageLogFileSize(String directory) async {
    if (_logFile != null && await _logFile!.length() > maxSizeInBytes) {
      final newPath = '$directory/app.log.${DateTime.now().millisecondsSinceEpoch}';
      await _logFile!.rename(newPath);
      _logFile = File('$directory/app.log');

      final logFiles = Directory(directory)
          .listSync()
          .where((file) => file.path.contains('app.log.'))
          .toList()
        ..sort((a, b) => a.statSync().modified.compareTo(b.statSync().modified));

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

  static void info(String message) {
    _instance._logger.info(message);
  }

  static void debug(String message) {
    _instance._logger.fine(message);
  }

  static void warning(String message) {
    _instance._logger.warning(message);
  }

  static void error(String message, [Object? error, StackTrace? stackTrace]) {
    _instance._logger.severe(message, error, stackTrace);
  }

  static void verbose(String message) {
    _instance._logger.finer(message);
  }
}
