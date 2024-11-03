import 'dart:io';
import 'dart:ui';

final isTest = Platform.environment.containsKey('FLUTTER_TEST');

const List<Locale> locales = [
  Locale('zh', 'CN'),
  Locale('zh', 'Hans'),
  Locale('en', 'US'),
];
