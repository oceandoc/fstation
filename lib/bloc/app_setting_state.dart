part of 'app_setting_bloc.dart';

class AppSettingState {
  AppSettingState({
    required this.language,
    required this.themeMode,
  });
  final String language;
  final ThemeMode themeMode;

  AppSettingState copyWith({
    String? language,
    ThemeMode? themeMode,
  }) {
    return AppSettingState(
      language: language ?? this.language,
      themeMode: themeMode ?? this.themeMode,
    );
  }
}
