import 'dart:io';

import 'package:android_id/android_id.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:uuid/uuid.dart';

import '../impl/logger.dart';
import '../impl/store.dart';
import 'app_method_channel.dart';
import 'constants.dart';

class DeviceInfo {
  static int? _androidSdk;
  static bool _isIPad = false;

  static bool get isIPad => _isIPad;
  static final Map<String, dynamic> deviceParams = {};

  static int? get androidSdk => _androidSdk;
  static String? _deviceId;

  static String? get deviceId => _deviceId;

  static Future<void> fetchDeviceId() async {
    if (_deviceId != null) return;
    _deviceId = await FlutterUdid.udid;
  }

  static Future<void> _loadDeviceInfo() async {
    try {
      if (kIsAndroid) {
        final androidInfo = await DeviceInfoPlugin().androidInfo;
        deviceParams
            .addAll(Map.from(androidInfo.data)..remove('systemFeatures'));
        _androidSdk = androidInfo.version.sdkInt;

        // same with FlutterUdid.udid?
        deviceParams['androidId'] = await const AndroidId().getId();
        deviceParams['userAgent'] = await AppMethodChannel.getUserAgent();
      } else if (kIsIOS) {
        final iosInfo = await DeviceInfoPlugin().iosInfo;
        _isIPad = iosInfo.model.toLowerCase().contains('ipad');
        deviceParams.addAll(Map.from(iosInfo.data)..remove('name'));
        deviceParams['CFNetworkVersion'] =
            await AppMethodChannel.getCFNetworkVersion();
      } else if (kIsMacOS) {
        final macOsInfo = await DeviceInfoPlugin().macOsInfo;
        deviceParams.addAll(Map.from(macOsInfo.data)..remove('computerName'));
      } else if (kIsLinux) {
        final linuxInfo = await DeviceInfoPlugin().linuxInfo;
        deviceParams.addAll(Map.from(linuxInfo.data));
      } else if (kIsWindows) {
        final windowsInfo = await DeviceInfoPlugin().windowsInfo;
        deviceParams
            .addAll(Map.from(windowsInfo.data)..remove('digitalProductId'));
      } else if (kIsWeb) {
        final webInfo = await DeviceInfoPlugin().webBrowserInfo;
        deviceParams.addAll({
          ...webInfo.data,
          'browserName': webInfo.browserName.name,
        });
      } else {
        deviceParams['operatingSystem'] = kOperatingSystem;
        deviceParams['operatingSystemVersion'] = kOperatingSystemVersion;
      }
    } catch (e, s) {
      Logger.error('failed to load device info', e, s);
      deviceParams['failed'] = e.toString();
    }
  }

  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  static String? _uuid;

  static String get uuid => _uuid ?? '----';

  static Future<void> _loadUniqueId() async {
    final deviceInfoPlugin = DeviceInfoPlugin();
    String? originId;

    if (kIsWeb) {
      originId = await Store.instance.getUuid();
      if (originId.isEmpty) {
        originId = const Uuid().v4();
        await Store.instance.setUuid(originId);
      }
    } else if (kIsAndroid) {
      originId = await const AndroidId().getId();
    } else if (kIsIOS) {
      originId = (await deviceInfoPlugin.iosInfo).identifierForVendor;
    } else if (kIsWindows) {
      final result = await Process.run(
        'reg',
        [
          'query',
          r'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Cryptography',
          '/v',
          'MachineGuid'
        ],
        runInShell: true,
      );
      final resultString = result.stdout.toString().trim();
      if (resultString.contains('MachineGuid') &&
          resultString.contains('REG_SZ')) {
        originId = resultString.trim().split(RegExp(r'\s+')).last;
      }
    } else if (kIsMacOS) {
      originId = (await DeviceInfoPlugin().macOsInfo).systemGUID;
    } else if (kIsLinux) {
      final result = await Process.run(
        'cat',
        ['/etc/machine-id'],
        runInShell: true,
      );
      final resultString = result.stdout.toString().trim();
      if (kDebugMode) {
        print('Linux machine id query:\n$resultString');
      }
      originId = resultString;
    } else {
      throw UnimplementedError(kOperatingSystem);
    }

    if (originId?.isNotEmpty != true) {
      originId = await Store.instance.getUuid();
      if (originId.isEmpty) {
        originId = const Uuid().v4();
        await Store.instance.setUuid(originId);
      }
    }

    _uuid = const Uuid().v5(Namespace.url.value, originId).toUpperCase();
    Logger.info('Unique ID: $_uuid');
  }

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  static bool get isDebugDevice {
    if (kDebugMode) return true;
    const excludeIds = [
      'C9DC5C4C-DB76-561A-8918-EEB334451EC5', // android
      'C150DF56-B65C-5167-852B-102D487D7159', // ios
      '42A8BE37-7BD5-5AFA-9F96-6BDCC13A540A', // ios store
      'BC87303D-6010-5DCE-90FB-68E8758EC260', // ios release
      'EFD686D5-2D83-56E5-8971-8F72D0D42D58', // macos
      '6986A299-F7CB-5BBF-9680-14ED34013C07', // windows
    ];
    return excludeIds.contains(DeviceInfo.uuid);
  }

  static Future<void> init() async {
    await _loadUniqueId();
    await _loadDeviceInfo();
  }

  static void initForTest() {
    _uuid = '00000000-0000-0000-0000-000000000000';
  }
}
