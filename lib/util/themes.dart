import 'package:flutter/material.dart';

import '../extension/auth_page_theme_extensions.dart';

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
    extensions: <ThemeExtension<dynamic>>{
      AuthPageThemeExtensions(
        linkColor: const Color.fromARGB(255, 125, 199, 192),
        errorTextColor: Colors.blue[200]!,
        prefixIconColor: Colors.white.withOpacity(0.5),
        fillColor: Colors.white.withOpacity(0.2),
        borderColor: Colors.white.withOpacity(0.4),
        textColor: Colors.white.withOpacity(1),
        hintTextColor: Colors.white.withOpacity(0.7),
        authFormGradientStartColor: Colors.black.withOpacity(0.5),
        authFormGradientEndColor: Colors.black.withOpacity(0.5),
        infoTextColor: Colors.white.withOpacity(1),
      ),
    },
  );

  ThemeData darkThemeData = ThemeData(
    useMaterial3: true,
    fontFamily: 'LexendDeca',
    fontFamilyFallback: fontFallback,
    brightness: Brightness.dark,
    colorSchemeSeed: const Color(0xFF0A040C),
    extensions: <ThemeExtension<dynamic>>{
      AuthPageThemeExtensions(
        linkColor: const Color(0xFFD39E70),
        prefixIconColor: const Color.fromARGB(255, 87, 57, 58),
        fillColor: const Color(0xFFA89C94),
        borderColor: const Color(0xFFA89C94),
        textColor: Colors.white,
        hintTextColor: const Color.fromARGB(255, 87, 57, 58),
        authFormGradientStartColor: const Color.fromARGB(216, 87, 57, 58),
        authFormGradientEndColor: const Color.fromARGB(155, 87, 57, 58),
        errorTextColor: Colors.red,
        // Replace with your desired color
        infoTextColor: Colors.white, // Replace with your desired color
      ),
    },
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
