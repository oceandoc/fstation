import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../ui/themes.dart';

extension IterableX<E> on Iterable<E> {
  E? firstWhereOrNull(bool Function(E element) test) {
    try {
      return firstWhere(test);
    } on StateError {
      return null;
    }
  }

  E? lastWhereOrNull(bool Function(E element) test) {
    try {
      return lastWhere(test);
    } on StateError {
      return null;
    }
  }

  E? get firstOrNull => isNotEmpty ? first : null;

  E? get lastOrNull => isNotEmpty ? last : null;
}

extension BorderRadiusSetting on double {
  double get multipliedRadius {
    return this * 1.0;
  }
}


extension DENumberUtils<E extends num> on E {
  E withMinimum(E min) {
    if (this < min) return min;
    return this;
  }

  E withMaximum(E max) {
    if (this > max) return max;
    return this;
  }
}

extension ContextUtils on BuildContext {
  ui.FlutterView get view => View.of(this);
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
  Color getPrimaryColor() => isLightMode ? lightPrimaryColor: darkPrimaryColor;
  Color getAccentColor() => isLightMode ? lightAccentColor: darkAccentColor;
  Color getChosenColor() => isLightMode ? lightChosenColor: darkChosenColor;
}

extension DEWidgetsSeparator on Iterable<Widget> {
  Iterable<Widget> addSeparators({required Widget separator, int skipFirst = 0}) sync* {
    final iterator = this.iterator;
    int count = 0;

    while (iterator.moveNext()) {
      if (count < skipFirst) {
        yield iterator.current;
      } else {
        yield separator;
        yield iterator.current;
      }
      count++;
    }
  }
}

