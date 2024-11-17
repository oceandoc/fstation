import 'dart:ui';

import 'package:flutter/material.dart';

class PlatformUtil {
  PlatformDispatcher get platform =>
      WidgetsFlutterBinding.ensureInitialized().platformDispatcher;

  FlutterView? get platformView => platform.implicitView;

  Locale? get deviceLocale => platform.locale;

  double get pixelRatio => platformView!.devicePixelRatio;

  Size get size => platformView!.physicalSize / pixelRatio;

  double get width => size.width;

  double get height => size.height;

  double get statusBarHeight => platformView!.padding.top;

  double get bottomBarHeight => platformView!.padding.bottom;

  /// Android Q+
  bool get isPlatformDarkMode => platform.platformBrightness == Brightness.dark;
}
