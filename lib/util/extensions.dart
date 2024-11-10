import 'dart:convert';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart' as material;
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import '../ui/themes.dart';
import 'constants.dart';

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

/// This widget should not have any dependency of outer [context]
extension DialogShowMethod on material.Widget {
  /// Don't use this when dialog children depend on [context] or need [State.setState]
  Future<T?> showDialog<T>(material.BuildContext? context,
      {bool barrierDismissible = true, bool useRootNavigator = false}) {
    context ??= kAppKey.currentContext;
    if (context == null) return Future.value();
    return material.showDialog<T>(
      context: context,
      builder: (context) => this,
      barrierDismissible: barrierDismissible,
      useRootNavigator: useRootNavigator,
    );
  }
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

extension DateTimeX on DateTime {
  static DateTime? tryParse(String? formattedString) {
    if (formattedString == null) return null;
    var date = DateTime.tryParse(formattedString);
    if (date != null) return date;
    // replace 2020-2-2 0:0 to 2020-02-02 00:00
    formattedString = formattedString.replaceFirstMapped(RegExp(r'^([+-]?\d{4})-?(\d{1,2})-?(\d{1,2})'), (match) {
      String year = match.group(1)!;
      String month = match.group(2)!.padLeft(2, '0');
      String day = match.group(3)!.padLeft(2, '0');
      return '$year-$month-$day';
    });
    formattedString = formattedString.replaceFirstMapped(RegExp(r'(\d{1,2}):(\d{1,2})$'), (match) {
      String hour = match.group(1)!.padLeft(2, '0');
      String minute = match.group(2)!.padLeft(2, '0');
      return '$hour:$minute';
    });
    return DateTime.tryParse(formattedString);
  }

  /// [this] is reference time, check [dateTime] outdated or not
  /// If [duration] is provided, compare [dateTime]-[duration] ~ this
  bool checkOutdated(DateTime? dateTime, [Duration? duration]) {
    if (dateTime == null) return false;
    if (duration != null) dateTime = dateTime.add(duration);
    return isAfter(dateTime);
  }

  String toStringShort({bool omitSec = false}) {
    return toString().replaceFirstMapped(RegExp(r'(:\d+)(\.\d+)(Z?)'), (match) {
      return omitSec || match.group(1) == ":00" ? match.group(3)! : match.group(1)! + match.group(3)!;
    });
  }

  String toDateString([String sep = '-']) {
    return [year, month.toString().padLeft(2, '0'), day.toString().padLeft(2, '0')].join(sep);
  }

  String toTimeString({bool seconds = true, bool milliseconds = false}) {
    String output = [hour, minute, if (seconds) second].map((e) => e.toString().padLeft(2, '0')).join(":");
    if (milliseconds) {
      output += '.${millisecond.toString().padLeft(3, "0")}';
    }
    return output;
  }

  String toCustomString({bool year = true, bool second = true, bool millisecond = false}) {
    String output = [
      if (year) this.year,
      month.toString().padLeft(2, '0'),
      day.toString().padLeft(2, '0'),
    ].join('-');
    output += ' ';
    output += [hour, minute, if (second) this.second].map((e) => e.toString().padLeft(2, '0')).join(":");
    if (second && millisecond) {
      output += '.${this.millisecond.toString().padLeft(3, "0")}';
    }
    return output;
  }

  String toSafeFileName([Pattern? pattern]) {
    return toString().replaceAll(pattern ?? RegExp(r'[^\d]'), '_');
  }

  static int compare(DateTime? a, DateTime? b) {
    if (a != null && b != null) {
      return a.compareTo(b);
    } else if (a != null) {
      return 1;
    } else if (b != null) {
      return -1;
    } else {
      return 0;
    }
  }

  int get timestamp => millisecondsSinceEpoch ~/ 1000;
}

extension StringX on String {
  int count(String s) {
    return split(s).length - 1;
  }

  String substring2(int start, [int? end]) {
    if (start >= length) return '';
    if (end != null) {
      if (end <= start) end = start;
      if (end > length) end = length;
    }
    return substring(start, end);
  }

  DateTime? toDateTime() {
    return DateTimeX.tryParse(this);
  }

  String toTitle() {
    return replaceAllMapped(RegExp(r'\S+'), (match) {
      String s = match.group(0)!;
      return s.substring(0, 1).toUpperCase() + s.substring(1);
    });
  }

  /// for half-width ascii: 1 char=1 byte, for full-width cn/jp 1 char=3 bytes mostly.
  /// assume there is no half-width cn/jp char.
  int get charWidth {
    return (length + utf8.encode(this).length) ~/ 2;
  }

  String trimChar(String chars) {
    return trimCharLeft(chars).trimCharRight(chars);
  }

  String trimCharLeft(String chars) {
    String s = this;
    while (s.isNotEmpty && chars.contains(s.substring(0, 1))) {
      s = s.substring(1);
    }
    return s;
  }

  String trimCharRight(String chars) {
    String s = this;
    while (s.isNotEmpty && chars.contains(s[s.length - 1])) {
      s = s.substring(0, s.length - 1);
    }
    return s;
  }

  String setMaxLines([int n = 1]) {
    final lines = split('\n');
    if (lines.length <= n) return this;
    return [lines.sublist(0, n).join('\n'), ...lines.skip(n)].join(' ');
  }

  String get breakWord {
    String breakWord = '';
    for (final element in runes) {
      breakWord += String.fromCharCode(element);
      breakWord += '\u200B';
    }
    return breakWord;
  }

  List<int> get utf8Bytes => utf8.encode(this);

  Text toText({
    Key? key,
    TextStyle? style,
    StrutStyle? strutStyle,
    TextAlign? textAlign,
    TextDirection? textDirection,
    Locale? locale,
    bool? softWrap,
    TextOverflow? overflow,
    TextScaler? textScaler,
    int? maxLines,
    String? semanticsLabel,
    TextWidthBasis? textWidthBasis,
    TextHeightBehavior? textHeightBehavior,
  }) {
    return Text(
      this,
      key: key,
      style: style,
      strutStyle: strutStyle,
      textAlign: textAlign,
      textDirection: textDirection,
      locale: locale,
      softWrap: softWrap,
      overflow: overflow,
      textScaler: textScaler,
      maxLines: maxLines,
      semanticsLabel: semanticsLabel,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
    );
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

  ThemeData get themeData => Theme.of(this);

  // Returns true if the app is using a dark theme
  bool get isDarkTheme => themeData.brightness == Brightness.dark;
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

