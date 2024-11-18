
import 'dart:ui';

import 'package:flutter/material.dart';

import '../util/themes.dart';

extension ContextExtension on BuildContext {
  FlutterView get view => View.of(this);
  EdgeInsets get padding => MediaQuery.paddingOf(this);
  EdgeInsets get viewPadding => MediaQuery.viewPaddingOf(this);
  EdgeInsets get viewInsets => MediaQuery.viewInsetsOf(this);
  Orientation get orientation => MediaQuery.orientationOf(this);
  double get pixelRatio => MediaQuery.devicePixelRatioOf(this);

  Size get size => MediaQuery.sizeOf(this);
  double get height => size.height;
  double get width => size.width;

  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  bool get isDarkMode => theme.brightness == Brightness.dark;
  bool get isLightMode => theme.brightness == Brightness.light;
  bool get isLandscape => orientation == Orientation.landscape;
  bool get isPortrait => orientation == Orientation.portrait;
  Color get primaryColor => Theme.of(this).primaryColor;
  // Color get accentColor => Theme.of(this).acc;
  // Color getAccentColor() => isLightMode ? lightAccentColor: darkAccentColor;
  // Color getChosenColor() => isLightMode ? lightChosenColor: darkChosenColor;

  ThemeData get themeData => Theme.of(this);
}
