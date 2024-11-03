part of 'app_setting_bloc.dart';

@immutable
sealed class AppSettingEvent {}


class ChangeLanguageEvent extends AppSettingEvent {
  final String language;

  ChangeLanguageEvent(this.language);
}

class ChangeThemeStyleEvent extends AppSettingEvent {
  final ThemeStyle themeStyle;

  ChangeThemeStyleEvent(this.themeStyle);
}

class ChangeThemeColorEvent extends AppSettingEvent {
  final String themeColor;

  ChangeThemeColorEvent(this.themeColor);
}