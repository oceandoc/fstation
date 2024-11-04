part of 'app_setting_bloc.dart';

class AppSettingState {
  AppSettingState({
    required this.language,
    required this.themeMode,
    required this.themeColor,
  });
  final String language;
  final String themeMode;
  final ThemeColor themeColor;

  AppSettingState copyWith({
    String? language,
    String? themeMode,
    ThemeColor? themeColor,
  }) {
    return AppSettingState(
      language: language ?? this.language,
      themeMode: themeMode ?? this.themeMode,
      themeColor: themeColor ?? this.themeColor,
    );
  }
}
