part of 'app_setting_bloc.dart';

@immutable
sealed class AppSettingEvent {}

class ChangeLanguageEvent extends AppSettingEvent {
  ChangeLanguageEvent(this.language);
  final String language;
}

class ChangeThemeModeEvent extends AppSettingEvent {
  ChangeThemeModeEvent(this.themeMode);
  final String themeMode;
}

class ChangeThemeColorEvent extends AppSettingEvent {
  ChangeThemeColorEvent(this.themeColor);
  final ThemeColor themeColor;
}

class LoadSettingsEvent extends AppSettingEvent {}  // New event
