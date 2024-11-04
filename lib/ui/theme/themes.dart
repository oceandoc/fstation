import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fstation/util/extensions.dart';

import '../../impl/setting.dart';
import '../../util/color.dart';
import '../../util/util.dart';

Color getThemeColor(ThemeColor themeColor) {
  switch (themeColor) {
    case ThemeColor.SYSTEM:
      return Colors.red;
    case ThemeColor.WHITE:
      return Colors.white;
    case ThemeColor.BLACK:
      return Colors.black;
  }
}

class AppThemes {
  static AppThemes get inst => _instance;
  static final AppThemes _instance = AppThemes._internal();
  AppThemes._internal();

  ThemeData getAppTheme(
      [Color? color, bool? light, bool lighterDialog = true]) {
    final settings = SettingImpl.instance;

    color ??= getThemeColor(settings.themeColor);
    light ??= settings.themeMode == 'Light';

    final mainColorMultiplier = 0.8;
    final pitchGrey = const Color.fromARGB(255, 35, 35, 35);

    int getColorAlpha(int a) => (a * mainColorMultiplier).round();
    Color getMainColorWithAlpha(int a) => color!.withAlpha(getColorAlpha(a));

    final cardTheme = CardTheme(
      elevation: 12.0,
      color: Color.alphaBlend(
        getMainColorWithAlpha(45),
        light ? const Color.fromARGB(255, 255, 255, 255) : pitchGrey,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14.0.multipliedRadius),
      ),
    );

    final cardColor = Color.alphaBlend(
      getMainColorWithAlpha(35),
      light ? const Color.fromARGB(255, 255, 255, 255) : pitchGrey,
    );

    const fontFallback = ['sans-serif', 'Roboto'];

    return ThemeData(
      brightness: light ? Brightness.light : Brightness.dark,
      useMaterial3: true,
      colorSchemeSeed: color,
      fontFamily: "LexendDeca",
      fontFamilyFallback: fontFallback,
      scaffoldBackgroundColor:
          (light ? Color.alphaBlend(color.withAlpha(60), Colors.white) : null),
      splashColor: Colors.transparent,
      splashFactory: InkRipple.splashFactory,
      highlightColor:
          light ? Colors.black.withAlpha(20) : Colors.white.withAlpha(25),
      disabledColor: light
          ? const Color.fromARGB(200, 160, 160, 160)
          : const Color.fromARGB(200, 60, 60, 60),
      applyElevationOverlayColor: false,
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        backgroundColor: (light
            ? Color.alphaBlend(color.withAlpha(25), Colors.white)
            : null),
        actionsIconTheme: IconThemeData(
          color: light
              ? const Color.fromARGB(200, 40, 40, 40)
              : const Color.fromARGB(200, 233, 233, 233),
        ),
      ),
      secondaryHeaderColor: light
          ? const Color.fromARGB(200, 240, 240, 240)
          : const Color.fromARGB(222, 10, 10, 10),
      navigationBarTheme: null,
      iconTheme: IconThemeData(
        color: light
            ? const Color.fromARGB(200, 40, 40, 40)
            : const Color.fromARGB(200, 233, 233, 233),
      ),
      shadowColor: light
          ? const Color.fromARGB(180, 100, 100, 100)
          : const Color.fromARGB(222, 10, 10, 10),
      dividerTheme: const DividerThemeData(
        thickness: 4,
        indent: 0.0,
        endIndent: 0.0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          visualDensity: VisualDensity.compact,
          padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(horizontal: 18.0, vertical: 14.0),
          ),
          iconSize: const WidgetStatePropertyAll(21.0),
          backgroundColor: WidgetStatePropertyAll(light
              ? Color.alphaBlend(getMainColorWithAlpha(30), Colors.white)
              : null),
        ),
      ),
      dialogBackgroundColor: lighterDialog
          ? light
              ? Color.alphaBlend(getMainColorWithAlpha(60), Colors.white)
              : Color.alphaBlend(getMainColorWithAlpha(20),
                  const Color.fromARGB(255, 12, 12, 12))
          : light
              ? Color.alphaBlend(getMainColorWithAlpha(35), Colors.white)
              : Color.alphaBlend(getMainColorWithAlpha(12),
                  const Color.fromARGB(255, 16, 16, 16)),
      focusColor: light
          ? const Color.fromARGB(200, 190, 190, 190)
          : const Color.fromARGB(150, 80, 80, 80),
      dialogTheme: DialogTheme(
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.0.multipliedRadius))),
      listTileTheme: ListTileThemeData(
        horizontalTitleGap: 16.0,
        selectedColor: light
            ? Color.alphaBlend(getMainColorWithAlpha(40),
                const Color.fromARGB(255, 182, 182, 182))
            : Color.alphaBlend(getMainColorWithAlpha(40),
                const Color.fromARGB(255, 55, 55, 55)),
        iconColor: Color.alphaBlend(
          getMainColorWithAlpha(80),
          light
              ? const Color.fromARGB(200, 55, 55, 55)
              : const Color.fromARGB(255, 228, 228, 228),
        ),
        textColor: Color.alphaBlend(
          getMainColorWithAlpha(80),
          light
              ? const Color.fromARGB(200, 55, 55, 55)
              : const Color.fromARGB(255, 228, 228, 228),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: Platform.isWindows
            ? const ButtonStyle(
                padding: WidgetStatePropertyAll(
                  EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                ),
                visualDensity: VisualDensity.compact,
              )
            : null,
      ),
      dividerColor: light
          ? const Color.fromARGB(100, 100, 100, 100)
          : const Color.fromARGB(200, 50, 50, 50),
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: light
              ? Color.alphaBlend(getMainColorWithAlpha(30),
                  const Color.fromARGB(255, 242, 242, 242))
              : Color.alphaBlend(getMainColorWithAlpha(80),
                  const Color.fromARGB(255, 12, 12, 12)),
          borderRadius: BorderRadius.circular(10.0.multipliedRadius),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(70, 12, 12, 12),
              blurRadius: 6.0,
              offset: Offset(0, 2),
            )
          ],
        ),
        textStyle: TextStyle(
          color: light
              ? const Color.fromARGB(244, 55, 55, 55)
              : const Color.fromARGB(255, 228, 228, 228),
        ),
        waitDuration: const Duration(seconds: 1),
      ),
      cardColor: cardColor,
      cardTheme: cardTheme,
      popupMenuTheme: PopupMenuThemeData(
        surfaceTintColor: Colors.transparent,
        elevation: 12.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0.multipliedRadius),
        ),
        color: light
            ? Color.alphaBlend(cardColor.withAlpha(180), Colors.white)
            : Color.alphaBlend(cardColor.withAlpha(180), Colors.black),
      ),
      textTheme: TextTheme(
        bodyMedium: const TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.normal,
          fontFamilyFallback: fontFallback,
        ),
        bodySmall: const TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.normal,
          fontFamilyFallback: fontFallback,
        ),
        titleSmall: const TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w600,
          fontFamilyFallback: fontFallback,
        ),
        titleLarge: const TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
          fontFamilyFallback: fontFallback,
        ),
        displayLarge: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 17.0,
          color:
              light ? Colors.black.withAlpha(160) : Colors.white.withAlpha(210),
          fontFamilyFallback: fontFallback,
        ),
        displayMedium: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 15.0,
          color:
              light ? Colors.black.withAlpha(150) : Colors.white.withAlpha(180),
          fontFamilyFallback: fontFallback,
        ),
        displaySmall: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 13.0,
          color:
              light ? Colors.black.withAlpha(120) : Colors.white.withAlpha(170),
          fontFamilyFallback: fontFallback,
        ),
        headlineMedium: const TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 14.0,
          fontFamilyFallback: fontFallback,
        ),
        headlineSmall: const TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 14.0,
          fontFamilyFallback: fontFallback,
        ),
      ),
    );
  }
}
