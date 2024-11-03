part of 'app_setting_bloc.dart';

class AppSettingState {
  AppSettingState({
    required this.language,
    required this.themeStyle ,
    required this.themeColor,
  });
  final String language;
  final ThemeStyle themeStyle;
  final String themeColor;

  AppSettingState copyWith({
    String? language,
    ThemeStyle? themeStyle,
    String? themeColor,
  }) {
    return AppSettingState(
      language: language ?? this.language,
      themeStyle: themeStyle ?? this.themeStyle,
      themeColor: themeColor ?? this.themeColor,
    );
  }
}