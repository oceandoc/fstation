import 'dart:async';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fstation/util/util.dart';
import 'package:image/image.dart' as lib_image;

class ImageUtil {
  const ImageUtil._();

  static const ColorFilter greyscalBeast = ColorFilter.matrix(<double>[
    // grey scale for beast icon
    0.8, 0.15, 0.05, 0, 0,
    0.8, 0.15, 0.05, 0, 0,
    0.8, 0.15, 0.05, 0, 0,
    0, 0, 0, 1, 0,
  ]);

  static Widget getChaldeaBackground(BuildContext context, {double height = 240}) {
    Widget img = Image(
      image: const AssetImage("res/img/chaldea.png"),
      filterQuality: FilterQuality.high,
      height: height,
    );
    if (nampack.isDarkMode) {
      // assume r=g=b
      int b = Theme.of(context).scaffoldBackgroundColor.blue;
      if (!kIsWeb) {
        double v = (255 - b) / 255;
        img = ColorFiltered(
          colorFilter: ColorFilter.matrix([
            //R G  B  A  Const
            -v, 0, 0, 0, 255,
            0, -v, 0, 0, 255,
            0, 0, -v, 0, 255,
            0, 0, 0, 0.8, 0,
          ]),
          child: img,
        );
      } else {
        img = ColorFiltered(
          colorFilter: const ColorFilter.matrix([
            // R    G       B       A  Const
            0.2126, 0.5152, 0.0722, 0, 0,
            0.2126, 0.5152, 0.0722, 0, 0,
            0.2126, 0.5152, 0.0722, 0, 0,
            0, 0, 0, 1, 0,
          ]),
          child: img,
        );
      }
    }
    return img;
  }

  static Future<Uint8List?> recordCanvas({
    required num width,
    required num height,
    required FutureOr<void> Function(Canvas canvas, Size size) paint,
    num? imgWidth,
    num? imgHeight,
    ui.ImageByteFormat format = ui.ImageByteFormat.png,
    FutureOr<Uint8List?> Function(dynamic e, dynamic s) onError = _defaultOnError,
  }) async {
    // if (kIsWeb && !kPlatformMethods.rendererCanvasKit) {
    //   await EasyLoading.showError('not supported using html renderer');
    //   return null;
    // }
    try {
      final recorder = ui.PictureRecorder();
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

  static FutureOr<Uint8List?> _defaultOnError(dynamic e, dynamic s) {
    // logger.e('record canvas failed', e, s);
    return null;
  }
}