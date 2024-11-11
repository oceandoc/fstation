import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:fstation/util/platform/platform.dart';
import 'package:image/image.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';

import '../impl/logger.dart';

class Screenshot {
  factory Screenshot() => _instance;

  Screenshot._internal() {
    _controller = ScreenshotController();
  }

  static final Screenshot _instance = Screenshot._internal();

  static Screenshot get instance => _instance;

  late final ScreenshotController _controller;

  ScreenshotController get controller => _controller;

  String? _saveDir;

  String get saveDir => _saveDir ?? '';

  /// Initialize screenshot functionality
  Future<void> init() async {
    if (kIsWeb) {
      _saveDir = '';
      return;
    }

    try {
      final appDir = await getApplicationDocumentsDirectory();
      _saveDir = path.join(appDir.path, 'screenshots');

      // Create screenshots directory if it doesn't exist
      final dir = Directory(_saveDir!);
      if (!dir.existsSync()) {
        await dir.create(recursive: true);
      }

      Logger.info('Screenshot directory: $_saveDir');
    } catch (e, stack) {
      Logger.error('Failed to initialize screenshot directory', e, stack);
      _saveDir = '';
    }
  }

  /// Fetch from https://gitee.com/chaldea-center/chaldea/wikis/blocked_error?sort_id=4200566
  /// Capture screenshot of the widget
  /// Returns the captured image as Uint8List
  Future<Uint8List?> capture() async {
    if (kIsWeb && !kPlatformMethods.rendererCanvasKit) return null;

    try {
      final shotBinary = await _controller.capture(
        pixelRatio: 1,
        delay: const Duration(milliseconds: 200),
      );
      if (shotBinary == null) return null;

      final img = decodePng(shotBinary);
      if (img == null) return null;

      final bytes = Uint8List.fromList(encodeJpg(img, quality: 60));

      // Save file only for non-web platforms
      if (!kIsWeb && _saveDir != null) {
        final timestamp = DateTime.now().millisecondsSinceEpoch;
        final filePath = path.join(_saveDir!, 'screenshot_$timestamp.jpg');

        await File(filePath).writeAsBytes(bytes);
        Logger.info('Screenshot saved to: $filePath');
      }

      return bytes;
    } on FileSystemException catch (e, s) {
      Logger.error('Failed to write screenshot file', e, s);
    } catch (e, stack) {
      Logger.error('Screenshot capture failed', e, stack);
      return null;
    }
  }

  /// Save screenshot to a file
  /// Returns the path to the saved file
  Future<String?> saveToFile([String? customPath]) async {
    try {
      final imageBytes = await capture();
      if (imageBytes == null) return null;

      final String filePath;
      if (customPath != null) {
        filePath = customPath;
      } else {
        if (_saveDir == null) {
          throw Exception('Screenshot directory not initialized');
        }
        filePath = path.join(
          _saveDir!,
          'screenshot_${DateTime.now().millisecondsSinceEpoch}.jpg',
        );
      }

      // Write the file
      final file = File(filePath);
      await file.writeAsBytes(imageBytes);
      Logger.info('Screenshot saved to: $filePath');
      return filePath;
    } catch (e, stack) {
      Logger.error('Screenshot save failed', e, stack);
      return null;
    }
  }

  /// Clean up old screenshots
  /// Keeps only the most recent [keepCount] screenshots
  Future<void> cleanOldScreenshots({int keepCount = 10}) async {
    if (kIsWeb || _saveDir == null) return;

    try {
      final dir = Directory(_saveDir!);
      if (!dir.existsSync()) return;

      final files = await dir
          .list()
          .where((entity) =>
              entity is File &&
              path.basename(entity.path).startsWith('screenshot_'))
          .toList();

      if (files.length <= keepCount) return;

      // Sort by modification time, newest first
      files.sort(
          (a, b) => b.statSync().modified.compareTo(a.statSync().modified));

      // Delete older files
      for (var i = keepCount; i < files.length; i++) {
        await (files[i] as File).delete();
      }

      Logger.info('Cleaned up old screenshots. Kept $keepCount files.');
    } catch (e, stack) {
      Logger.error('Failed to clean old screenshots', e, stack);
    }
  }
}
