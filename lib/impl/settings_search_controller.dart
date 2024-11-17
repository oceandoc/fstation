import 'package:flutter/material.dart';
import '../util/enums.dart';

class SettingsSearchController {
  static final SettingsSearchController inst = SettingsSearchController._internal();
  SettingsSearchController._internal();
  final _map = <SettingSubpageEnum, Map<int, GlobalKey>>{};
  GlobalKey getSettingWidgetGlobalKey(SettingSubpageEnum settingPage, Enum key) {
    final keyIndex = key.index;
    final c = SettingsSearchController.inst;
    final r = settingPage;
    c._map[r] ??= {};
    c._map[r]![keyIndex] ??= GlobalKey();
    return c._map[r]![keyIndex]!;
  }
}
