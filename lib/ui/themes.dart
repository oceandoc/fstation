import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fstation/util/extensions.dart';

import '../impl/setting.dart';

const lightPrimaryColor = Color(0xFFFFFFFF);
const lightAccentColor = Color(0xFF3D75E3);

const darkPrimaryColor = Color(0xFF000000);
const darkAccentColor = Color(0xFF3D75E3);


int getColorAlpha(int a) => (a * 0.8).round();
Color getPrimaryColorWithAlpha(bool light, int a) {
  if (light) {
    return lightPrimaryColor.withAlpha(getColorAlpha(a));
  }
  return darkPrimaryColor.withAlpha(getColorAlpha(a));
}

Color getPrimaryColor(bool light) => light ? lightPrimaryColor: darkPrimaryColor;

var secondoryTextStyleMedium =
TextStyle(fontFamily: "Gilroy", fontWeight: FontWeight.w700);

class AppThemes {
  static AppThemes get instance => _instance;
  static final AppThemes _instance = AppThemes._internal();
  AppThemes._internal();

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
