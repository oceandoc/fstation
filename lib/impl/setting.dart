import '../bloc/app_setting_bloc.dart';
import '../util/color.dart';
import 'db.dart';

class SettingImpl {
  SettingImpl({
    this.themeMode = 'System',
    this.themeColor = ThemeColor.SYSTEM,
    this.language = 'zh',
    this.firstLanuch = true,
  });

  String themeMode;
  ThemeColor themeColor;
  String language;
  bool firstLanuch;

  Future<void> init() async {
    await getSettings();
  }

  Future<AppSettingState> getSettings() async {
    language = Db.get(DbKey.language, 'zh');
    themeMode = Db.get(DbKey.themeMode, 'System');
    themeColor = Db.get(DbKey.themeColor, ThemeColor.SYSTEM) as ThemeColor;
    firstLanuch = Db.get(DbKey.firstLanuch, true);

    final settingState = AppSettingState(
      themeMode: themeMode,
      themeColor: themeColor,
      language: language,
    );
    return settingState;
  }

  void saveThemeMode(String themeMode) {
    this.themeMode = themeMode;
    setSetting(DbKey.themeMode, themeMode);
  }

  void saveThemeColor(ThemeColor themeColor) {
    this.themeColor = themeColor;
    setSetting(DbKey.themeColor, themeColor);
  }

  void saveLanguage(String language) {
    this.language = language;
    setSetting(DbKey.language, language);
  }

  void saveFirstLanuch({required  bool firstLanuch}) {
    this.firstLanuch = firstLanuch;
    setSetting(DbKey.firstLanuch, firstLanuch);
  }

  void setSetting<T>(DbKey<T> key, T value) {
    switch (key) {
      case DbKey.themeMode:
        themeMode = value as String;
      case DbKey.themeColor:
        themeColor = value as ThemeColor;
      case DbKey.language:
        language = value as String;
      case DbKey.assetETag:
      // TODO(xieyz): Handle this case.
      case DbKey.deviceIdHash:
      // TODO(xieyz): Handle this case.
      case DbKey.deviceId:
      // TODO(xieyz): Handle this case.
      case DbKey.version:
      // TODO(xieyz): Handle this case.
      case DbKey.firstLanuch:
      // TODO(xieyz): Handle this case.
    }
    Db.put(key, value);
  }
}
