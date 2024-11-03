import 'package:bloc/bloc.dart';
import 'package:fstation/impl/db.dart';
import 'package:meta/meta.dart';

import '../impl/setting.dart';
import '../util/theme_style.dart';

part 'app_setting_event.dart';
part 'app_setting_state.dart';

class AppSettingBloc extends Bloc<AppSettingEvent, AppSettingState> {
  final SettingImpl settingImpl;

  AppSettingBloc(this.settingImpl)
      : super(AppSettingState(
      language: 'en', themeStyle: ThemeStyle.AUTO, themeColor: 'blue')) {
    _loadSettings();

    // Handle each event using the `on` method
    on<ChangeLanguageEvent>((event, emit) async {
      final newState = state.copyWith(language: event.language);
      emit(newState);
      settingImpl.setSetting(DbKey.language, newState.language);
    });

    on<ChangeThemeStyleEvent>((event, emit) async {
      final newState = state.copyWith(themeStyle: event.themeStyle);
      emit(newState);
      settingImpl.setSetting(DbKey.themeStyle, newState.themeStyle);
    });

    on<ChangeThemeColorEvent>((event, emit) async {
      final newState = state.copyWith(themeColor: event.themeColor);
      emit(newState);
      settingImpl.setSetting(DbKey.themeColor, newState.themeColor);
    });
  }

  // Load settings from the database when bloc is initialized
  void _loadSettings() async {
    final settings = await settingImpl.getSettings();
    emit(settings);
  }
}
