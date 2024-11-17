import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:fstation/impl/setting_impl.dart';
import '../impl/logger.dart';
import 'constants.dart';

const MethodChannel kMethodChannel =
    MethodChannel('com.xiedeacc.fstation/fstation');

class AppMethodChannel {
  static void configMethodChannel() {
    kMethodChannel.setMethodCallHandler((call) async {
      Logger.info('[dart] on call: ${call.method}, ${call.arguments}');
      if (call.method == 'onWindowPos') {
        final arguments = call.arguments as Map<String, dynamic>?;
        if (arguments != null && arguments['pos'] != null) {
          final pos = List<int>.from(arguments['pos'] as List<int>);
          Logger.info('onWindowRect: args=$arguments');
          await SettingImpl.instance.saveWindowsPosition(pos);
          return;
        } else {
          Logger.info('onWindowRect invalid args=$arguments');
          return;
        }
      }
    });
  }

  /// Send app to background rather exit when pop root route
  ///
  /// only available on Android
  static Future<void> sendBackground() async {
    assert(kIsAndroid, 'only support android');
    if (kIsAndroid) {
      return kMethodChannel.invokeMethod('sendBackground');
    }
  }

  @Deprecated('use [windowManager]')
  static Future<void> setAlwaysOnTop({bool? onTop}) async {
    if (kIsWindows || kIsMacOS) {
      onTop ??= SettingImpl.instance.windowsAlwaysOnTop;
      return kMethodChannel.invokeMethod<bool?>(
        'alwaysOnTop',
        <String, dynamic>{
          'onTop': onTop,
        },
      ).then((value) => Logger.info('alwaysOnTop success = $value'));
    }
  }

  static Future<void> setWindowPos([dynamic rect]) async {
    if (kIsWindows) {
      rect ??= SettingImpl.instance.windowsPosition;
      if (kDebugMode) {
        Logger.info('rect ${rect.runtimeType}: $rect');
      }
      if (rect != null &&
          rect is List &&
          rect.length == 4 &&
          rect.any((e) => e is int && e > 0)) {
        if (kDebugMode) {
          Logger.info('ready to set window rect: $rect');
        }
        return kMethodChannel.invokeMethod('setWindowRect', <String, dynamic>{
          'pos': rect,
        });
      }
    }
  }

  static Future<String?> getUserAgent() async {
    assert(kIsAndroid, 'only support android');
    if (kIsAndroid) {
      return kMethodChannel.invokeMethod('getUserAgent');
    }
    return null;
  }

  static Future<String?> getCFNetworkVersion() async {
    assert(kIsIOS, 'only support ios');
    if (kIsIOS) {
      return kMethodChannel.invokeMethod('getCFNetworkVersion');
    }
    return null;
  }
}
