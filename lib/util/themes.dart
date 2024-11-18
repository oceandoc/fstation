import 'package:flutter/material.dart';

class AppThemes {
  AppThemes._internal();

  static AppThemes get instance => _instance;
  static final AppThemes _instance = AppThemes._internal();
  static const fontFallback = ['sans-serif', 'Roboto'];

  ThemeData lightThemeData = ThemeData(
    useMaterial3: true,
    fontFamily: 'LexendDeca',
    fontFamilyFallback: fontFallback,
    brightness: Brightness.light,
    colorSchemeSeed: Colors.white,
  );

  ThemeData darkThemeData = ThemeData(
    useMaterial3: true,
    fontFamily: 'LexendDeca',
    fontFamilyFallback: fontFallback,
    brightness: Brightness.dark,
    colorSchemeSeed: const Color(0xFF0A040C),
  );
}

// class AppColorScheme {
//   AppColorScheme({required this.light, required this.dark});
//
//   ColorScheme light;
//   ColorScheme dark;
// }
//
// AppColorScheme? _dynamicColorTheme;
//
// Future<void> fetchSystemPalette() async {
//   try {
//     final corePalette = await DynamicColorPlugin.getCorePalette();
//     if (corePalette != null) {
//       final primaryColor = corePalette.toColorScheme().primary;
//       _dynamicColorTheme = AppColorScheme(
//         light: ColorScheme.fromSeed(
//           seedColor: primaryColor,
//         ),
//         dark: ColorScheme.fromSeed(
//           seedColor: primaryColor,
//           brightness: Brightness.dark,
//         ),
//       );
//     }
//   } catch (e) {
//     debugPrint('dynamic_color: Failed to obtain core palette.');
//   }
// }
