import 'dart:async';
import 'dart:ui';

import 'package:flutter/foundation.dart';


import '../impl/logger.dart';

class ImageUtil {
  const ImageUtil._();

  static Future<Uint8List?> recordCanvas({
    required num width,
    required num height,
    required FutureOr<void> Function(Canvas canvas, Size size) paint,
    num? imgWidth,
    num? imgHeight,
    ImageByteFormat format = ImageByteFormat.png,
    FutureOr<Uint8List?> Function(Object? e, StackTrace? s) onError = _defaultOnError,
  }) async {
    // if (kIsWeb && !kPlatformMethods.rendererCanvasKit) {
    //   await EasyLoading.showError('not supported using html renderer');
    //   return null;
    // }
    try {
      final recorder = PictureRecorder();
      final size = Size(width.toDouble(), height.toDouble());
      final canvas = Canvas(recorder, Rect.fromLTWH(0, 0, size.width, size.height));
      await paint(canvas, size);
      final picture = recorder.endRecording();
      await Future.delayed(const Duration(milliseconds: 50));
      final img = await picture.toImage((imgWidth ?? width).toInt(), (imgHeight ?? height).toInt());
      final imgBytes = (await img.toByteData(format: format))?.buffer.asUint8List();
      return imgBytes;
    } catch (e, s) {
      return onError(e, s);
    }
  }

  static FutureOr<Uint8List?> _defaultOnError(Object? e, StackTrace? s) {
    Logger.error('record canvas failed', e, s);
    return null;
  }
}
