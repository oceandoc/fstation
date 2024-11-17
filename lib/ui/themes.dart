import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:fstation/extension/extensions.dart';

import '../impl/setting_impl.dart';

const lightPrimaryColor = Color(0xFFFFFFFF);
const lightAccentColor = Color(0xFF3D75E3);
const lightChosenColor = Color(0xFF3D75E3);

const darkPrimaryColor = Color(0xFF0A040C);
const darkAccentColor = Color(0xFF3D75E3);
const darkChosenColor = Color(0xFF3D75E3);


int getColorAlpha(int a) => (a * 0.8).round();
Color getPrimaryColorWithAlpha(bool light, int a) {
  if (light) {
    return lightPrimaryColor.withAlpha(getColorAlpha(a));
  }
  return darkPrimaryColor.withAlpha(getColorAlpha(a));
}

class ImmichTheme {
  ColorScheme light;
  ColorScheme dark;

  ImmichTheme({required this.light, required this.dark});
}

ImmichTheme? _immichDynamicTheme;


Future<void> fetchSystemPalette() async {
  try {
    final corePalette = await DynamicColorPlugin.getCorePalette();
    if (corePalette != null) {
      final primaryColor = corePalette.toColorScheme().primary;
      _immichDynamicTheme = ImmichTheme(
        light: ColorScheme.fromSeed(
          seedColor: primaryColor,
        ),
        dark: ColorScheme.fromSeed(
          seedColor: primaryColor,
          brightness: Brightness.dark,
        ),
      );
    }
  } catch (e) {
    debugPrint('dynamic_color: Failed to obtain core palette.');
  }
}



TextStyle secondaryTextStyleMedium =
const TextStyle(fontFamily: 'Gilroy', fontWeight: FontWeight.w700);

class AppThemes {
  AppThemes._internal();
  static AppThemes get instance => _instance;
  static final AppThemes _instance = AppThemes._internal();

  ThemeData getAppTheme(
      [ bool? light, bool lighterDialog = true]) {
    light ??= SettingImpl.instance.themeMode == ThemeMode.light;
    final cardTheme = CardTheme(
      elevation: 12,
      color: Color.alphaBlend(
        getPrimaryColorWithAlpha(light, 45),
        light ? lightPrimaryColor : darkPrimaryColor,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14.0.multipliedRadius),
      ),
    );
    final cardColor = Color.alphaBlend(
      getPrimaryColorWithAlpha(light, 35),
      light ? lightPrimaryColor : darkPrimaryColor,
    );
    const fontFallback = ['sans-serif', 'Roboto'];
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'LexendDeca',
      fontFamilyFallback: fontFallback,
      brightness: light ? Brightness.light : Brightness.dark,
      colorSchemeSeed: light ? Colors.white : Colors.black,
    );
  }
}
