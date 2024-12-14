import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../generated/error.pbenum.dart';
import '../generated/l10n.dart';
import '../impl/grpc_client.dart';
import '../impl/logger.dart';
import '../impl/setting_impl.dart';

Future<bool> connectAndHandshake() async {
  if (SettingImpl.instance.serverAddr.isEmpty) {
    Logger.error('wrong grpc server url');
    return false;
  }

  try {
    // Try to connect and handshake with each discovered server

    final serverParts = SettingImpl.instance.serverAddr.split(':');
    if (serverParts.length == 2) {
      final host = serverParts[0];
      final port = int.tryParse(serverParts[1]) ?? 0;
      if (port > 0) {
        await GrpcClient.instance.connect(host, port);
      }
    }

    // TODO(xieyz): add a timeout, avoid stop main thread too long
    final response = await GrpcClient.instance.handshake();
    if (response.errCode == ErrCode.Success &&
        response.handshakeMsg ==
            '7a3be8186493f1bc834e3a6b84fcb2f9dc6d042e93d285ec23fa56836889dfa9' &&
        response.serverUuid.isNotEmpty) {
      if (response.serverUuid != SettingImpl.instance.serverUuid) {
        await SettingImpl.instance.saveServerUuid(response.serverUuid);
      }
      return true;
    }
  } catch (e) {
    Logger.error(
        'Failed to connect to  server: $SettingImpl.instance.serverAddr', e);
  }
  return false;
}



String themeModeName(ThemeMode mode) {
  switch (mode) {
    case ThemeMode.dark:
      return Localization.current.theme_setting_dark_mode_dark;
    case ThemeMode.light:
      return Localization.current.theme_setting_dark_mode_light;
    case ThemeMode.system:
      return Localization.current.theme_setting_dark_mode_system;
  }
}

void showToast(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.pinkAccent,
      textColor: Colors.white,
      fontSize: 16);
}

Locale getLocale(String code) {
  final locale = Locale.fromSubtags(languageCode: code);
  if (Localization.delegate.isSupported(locale)) {
    return locale;
  }
  return Localization.delegate.supportedLocales.first;
}

String getLocaleName(Locale local) {
  if (local.languageCode == 'en') {
    return 'English';
  } else if (local.languageCode == 'zh') {
    return '中文';
  }
  return 'English';
}
