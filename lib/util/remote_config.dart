import 'dart:convert';

import '../impl/logger.dart';

class RemoteConfig {

  // Factory constructor to return the same instance
  factory RemoteConfig() => _instance;
  // Private constructor
  RemoteConfig._internal();

  // Singleton instance
  static final RemoteConfig _instance = RemoteConfig._internal();

  // Static getter for easy access
  static RemoteConfig get instance => _instance;

  List<String>? _blockedErrors;

  List<String> get blockedErrors => _blockedErrors ?? [];

  set blockedErrors(List<String> value) {
    _blockedErrors = value;
    Logger.debug('_blockedErrors=${jsonEncode(_blockedErrors)}');
  }
}
