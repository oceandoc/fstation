import 'package:flutter/material.dart';

class AuthPageThemeExtensions extends ThemeExtension<AuthPageThemeExtensions> {
  // color for text on auth page

  AuthPageThemeExtensions({
    required this.linkColor,
    required this.backgroundImage,
    required this.errorTextColor,
    required this.prefixIconColor,
    required this.hintTextColor,
    required this.textColor,
    required this.borderColor,
    required this.fillColor,
    required this.authFormGradientStartColor,
    required this.authFormGradientEndColor,
    required this.infoTextColor,
  });

  final String backgroundImage; // path for background image
  final Color linkColor; // color for clickable links (in auth page)
  final Color errorTextColor; // color for error messages in auth page
  final Color prefixIconColor;
  final Color hintTextColor;
  final Color textColor; // color of email and password inputs
  final Color borderColor; // color of TextField in email and password inputs
  final Color fillColor; // fillColor of TextField in email and password inputs
  final Color authFormGradientStartColor;
  final Color authFormGradientEndColor;
  final Color infoTextColor;

  @override
  ThemeExtension<AuthPageThemeExtensions> copyWith({
    String? backgroundImage,
    Color? linkColor,
    Color? errorTextColor,
    Color? prefixIconColor,
    Color? hintTextColor,
    Color? textColor,
    Color? borderColor,
    Color? fillColor,
    Color? authFormGradientStartColor,
    Color? authFormGradientEndColor,
    Color? infoTextColor,
  }) {
    return AuthPageThemeExtensions(
        backgroundImage: backgroundImage ?? this.backgroundImage,
        linkColor: linkColor ?? this.linkColor,
        errorTextColor: errorTextColor ?? this.errorTextColor,
        prefixIconColor: prefixIconColor ?? this.prefixIconColor,
        hintTextColor: hintTextColor ?? this.hintTextColor,
        textColor: textColor ?? this.textColor,
        borderColor: borderColor ?? this.borderColor,
        fillColor: fillColor ?? this.fillColor,
        authFormGradientStartColor:
            authFormGradientStartColor ?? this.authFormGradientStartColor,
        authFormGradientEndColor:
            authFormGradientEndColor ?? this.authFormGradientEndColor,
        infoTextColor: infoTextColor ?? this.infoTextColor);
  }

  @override
  ThemeExtension<AuthPageThemeExtensions> lerp(
      covariant AuthPageThemeExtensions? other, double t) {
    return AuthPageThemeExtensions(
      backgroundImage: backgroundImage,
      linkColor: Color.lerp(linkColor, other?.linkColor, t)!,
      errorTextColor: Color.lerp(errorTextColor, other?.errorTextColor, t)!,
      prefixIconColor: Color.lerp(prefixIconColor, other?.prefixIconColor, t)!,
      hintTextColor: Color.lerp(hintTextColor, other?.hintTextColor, t)!,
      textColor: Color.lerp(textColor, other?.textColor, t)!,
      borderColor: Color.lerp(borderColor, other?.borderColor, t)!,
      fillColor: Color.lerp(fillColor, other?.fillColor, t)!,
      authFormGradientStartColor: Color.lerp(
          authFormGradientStartColor, other?.authFormGradientStartColor, t)!,
      authFormGradientEndColor: Color.lerp(
          authFormGradientEndColor, other?.authFormGradientEndColor, t)!,
      infoTextColor: Color.lerp(infoTextColor, other?.infoTextColor, t)!,
    );
  }
}
