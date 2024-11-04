import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:fstation/impl/db.dart';
import 'package:fstation/util/color.dart';

import '../impl/setting.dart';

part 'app_setting_event.dart';
part 'app_setting_state.dart';

class AppSettingBloc extends Bloc<AppSettingEvent, AppSettingState> {
  final SettingImpl settingImpl;

  AppSettingBloc(this.settingImpl)
      : super(AppSettingState(
          language: 'en',
          themeMode: 'System',
          themeColor: ThemeColor.SYSTEM,
        )) {
    // Handle each event using the `on` method
    on<LoadSettingsEvent>((event, emit) async {
      await _loadSettings(emit);
    });

    on<ChangeLanguageEvent>((event, emit) async {
      final newState = state.copyWith(language: event.language);
      emit(newState);
      settingImpl.setSetting(DbKey.language, newState.language);
    });

    on<ChangeThemeModeEvent>((event, emit) async {
      final newState = state.copyWith(themeMode: event.themeMode);
      emit(newState);
      settingImpl.setSetting(DbKey.themeMode, newState.themeMode);
    });

    on<ChangeThemeColorEvent>((event, emit) async {
      final newState = state.copyWith(themeColor: event.themeColor);
      emit(newState);
      settingImpl.setSetting(DbKey.themeColor, newState.themeColor);
    });
  }

  @override
  void onTransition(Transition<AppSettingEvent, AppSettingState> transition) {
    super.onTransition(transition);
    if (transition.currentState is AppSettingState &&
        transition.event is! LoadSettingsEvent) {
      add(LoadSettingsEvent());
    }
  }

  // Load settings from the database and emit the new state
  Future<void> _loadSettings(Emitter<AppSettingState> emit) async {
    final settings = await settingImpl.getSettings();
    emit(settings);
  }
}
