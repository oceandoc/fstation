import 'package:isar/isar.dart';

import '../bloc/app_setting_bloc.dart';
import '../util/theme_style.dart';
import 'db.dart';

@Collection()
class AppSetting {
  String? i18n;
  String? i18nCC;
  late int imgCompress;
  late ThemeStyle themeStyle;
  int? themeColor;
  String? fontFamily;
  double? fontSize;
  int version;
  String language;

  AppSetting({
    this.i18n,
    this.i18nCC,
    this.imgCompress = 50,
    this.themeStyle = ThemeStyle.AUTO,
    this.themeColor,
    this.fontFamily,
    this.fontSize,
    this.version = 0,
    this.language = 'en',
  });
}

class SettingImpl {
  AppSetting? _appSetting;
  SettingImpl();
  /// theme style

  Future<AppSettingState> getSettings() async {
    String language = Db.get(DbKey.language);
    ThemeStyle  themeStyle = Db.get(DbKey.themeStyle) as ThemeStyle;
    String themeColor = Db.get(DbKey.themeColor);

    AppSettingState settingState = AppSettingState(language: language, themeStyle: themeStyle, themeColor: themeColor);
    Db.get(DbKey.language);
    return settingState;
  }

  int get themeStyle => _appSetting!.themeStyle as int;

  void setSetting<T>(DbKey<T> key, T value) {
    switch(key) {
      case DbKey.version:
        _appSetting?.version = value as int;
      case DbKey.themeStyle:
        _appSetting?.themeStyle = value as ThemeStyle;
      case DbKey.themeColor:
        _appSetting?.themeColor = value as int;
      case DbKey.language:
        _appSetting?.language = value as String;
      case DbKey.assetETag:
        // TODO: Handle this case.
      case DbKey.deviceIdHash:
        // TODO: Handle this case.
      case DbKey.deviceId:
        // TODO: Handle this case.
    }
    Db.put(key, value);
  }

}