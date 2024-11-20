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
    //primaryColor:  Colors.white,
    extensions: <ThemeExtension<dynamic>>{
      AuthPageThemeExtensions(
        linkColor: const Color.fromARGB(255, 125, 199, 192),
        prefixIconColor: const Color(0xFF363536),
        fillColor: const Color(0xFF757777),
        borderColor: const Color(0xFF817065),
        textColor: Colors.white,
        hintTextColor: Colors.white.withOpacity(0.7),
        authFormGradientStartColor: const Color(0xFF9C9B99),
        authFormGradientEndColor: const Color(0xFF929084),
        errorTextColor: Colors.red,
        infoTextColor: Colors.white.withOpacity(1),
      ),
    },
  );

  ThemeData darkThemeData = ThemeData(
    useMaterial3: true,
    fontFamily: 'LexendDeca',
    fontFamilyFallback: fontFallback,
    brightness: Brightness.dark,
    colorSchemeSeed: Colors.black,
    // primaryColor:  Colors.black,
    scaffoldBackgroundColor: const Color(0xFF0A030A),

    extensions: <ThemeExtension<dynamic>>{
      AuthPageThemeExtensions(
        linkColor: const Color(0xFFD39E70),
        prefixIconColor: const Color(0xFF0A040C),
        fillColor: const Color(0xFF817065),
        borderColor: const Color(0xFFA89C94),
        textColor: Colors.white,
        hintTextColor: const Color(0xFFA89C94),
        authFormGradientStartColor: const Color(0xFF0A040C),
        authFormGradientEndColor: const Color(0xFF0A040C),
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
