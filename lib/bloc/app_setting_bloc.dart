import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fstation/impl/db.dart';

import '../impl/setting.dart';

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
      final newState = state.copyWith(language: event.language);
      emit(newState);
      SettingImpl.instance.saveLanguage(newState.language);
    });

    on<ChangeThemeModeEvent>((event, emit) async {
      final newState = state.copyWith(themeMode: event.themeMode);
      emit(newState);
      SettingImpl.instance.saveThemeMode(newState.themeMode);
    });
  }

  @override
  void onTransition(Transition<AppSettingEvent, AppSettingState> transition) {
    super.onTransition(transition);
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
