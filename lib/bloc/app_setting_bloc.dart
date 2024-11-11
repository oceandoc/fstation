import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../impl/setting_impl.dart';

part 'app_setting_event.dart';
part 'app_setting_state.dart';

class AppSettingBloc extends Bloc<AppSettingEvent, AppSettingState> {
  AppSettingBloc()
      : super(AppSettingState(
          language: SettingImpl.instance.language,
          themeMode: SettingImpl.instance.themeMode,
        )) {
    // Handle each event using the `on` method
    on<LoadSettingsEvent>((event, emit) async {
      await _loadSettings(emit);
    });

    on<ChangeLanguageEvent>((event, emit) async {
      await SettingImpl.instance.saveLanguage(event.language);
      final newState = state.copyWith(language: event.language);
      emit(newState);
    });

    on<ChangeThemeModeEvent>((event, emit) async {
      await SettingImpl.instance.saveThemeMode(event.themeMode);
      final newState = state.copyWith(themeMode: event.themeMode);
      emit(newState);
    });
  }

  @override
  void onTransition(Transition<AppSettingEvent, AppSettingState> transition) {
    super.onTransition(transition);
    // Don't trigger LoadSettingsEvent on LoadSettingsEvent to avoid infinite loop
    if (transition.event is! LoadSettingsEvent) {
      add(LoadSettingsEvent());
    }
  }

  // Load settings from the database and emit the new state
  Future<void> _loadSettings(Emitter<AppSettingState> emit) async {
    final settings = await SettingImpl.instance.getSettings();
    emit(settings);
  }
}
