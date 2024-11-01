import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit() : super(ThemeData.light());

  void toggleTheme() {
    emit(state.brightness == Brightness.dark ? ThemeData.light() : ThemeData.dark());
  }
}
