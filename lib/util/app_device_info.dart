import 'dart:async';
import 'dart:io';

import 'package:android_id/android_id.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:fstation/util/util.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path/path.dart' as pathlib;
import 'package:uuid/uuid.dart';

import '../generated/git_info.dart';
import '../impl/logger.dart';
import 'app_method_channel.dart';
import 'file_plus/file_plus.dart';

enum MacAppType {
  unknown,
  store,
  notarized,
  debug,
  notMacApp,
}

final isTest = Platform.environment.containsKey('FLUTTER_TEST');
const String kAppName = 'FastStation';
const String kPackageName = 'com.xiedeacc.fstation';
const String kPackageNameFDroid = 'com.xiedeacc.fstation.fdroid';

final bool kIsLinux = !kIsWeb && Platform.isLinux;
final bool kIsMacOS = !kIsWeb && Platform.isMacOS;
final bool kIsWindows = !kIsWeb && Platform.isWindows;
final bool kIsAndroid = !kIsWeb && Platform.isAndroid;
final bool kIsIOS = !kIsWeb && Platform.isIOS;
final bool kIsMobile = kIsAndroid || kIsIOS;
final bool kIsDesktop = kIsWindows || kIsMacOS || kIsLinux;
final bool kIsApple = kIsIOS || kIsMacOS;
final String kOperatingSystem = kIsWeb ? 'browser' : Platform.operatingSystem;
final String kOperatingSystemVersion =
    kIsWeb ? '' : Platform.operatingSystemVersion;
final String kResolvedExecutable = kIsWeb ? '' : Platform.resolvedExecutable;
final bool kSupportCopyImage =
    kIsWeb || Platform.isIOS || Platform.isMacOS || Platform.isWindows;

bool get isTargetMobile => [TargetPlatform.android, TargetPlatform.iOS]
    .contains(defaultTargetPlatform);

bool get isTargetDesktop => !isTargetMobile;
const bool supportScreenshot = !kIsWeb;

class AppDeviceInfo {
  static PackageInfo? _packageInfo;
  static DateTime? buildDate;
  static bool _fetchedPackageInfo = false;
  static final packageInfoCompleter = Completer<PackageInfo>();

  static PackageInfo? get packageInfo => _packageInfo;

  static String get packageName => packageInfo?.packageName ?? kPackageName;

  static bool get isFDroid => kIsAndroid && packageName == kPackageNameFDroid;

  static String get appName {
    if (_packageInfo?.appName.isNotEmpty ?? false) {
      return _packageInfo!.appName;
    } else {
      return kAppName;
    }
  }

  static String get versionString => _packageInfo?.version ?? '';

  static int get buildNumber =>
      int.tryParse(_packageInfo?.buildNumber ?? '0') ?? 0;

  static String get fullVersion {
    var s = '';
    s += versionString;
    if (buildNumber > 0) s += '+$buildNumber';
    return s;
  }

  static String get fullVersion2 {
    final buffer = StringBuffer(versionString);
    if (buildNumber > 0) {
      buffer.write(' ($buildNumber)');
    }
    return buffer.toString();
  }

  static void _parseBuildNumber(String buildNumber) {
    try {
      var hours = 0;
      var minutes = 0;
      final yyMMddHHP = buildNumber;
      final year = 2000 + int.parse('${yyMMddHHP[0]}${yyMMddHHP[1]}');
      final month = int.parse('${yyMMddHHP[2]}${yyMMddHHP[3]}');
      final day = int.parse('${yyMMddHHP[4]}${yyMMddHHP[5]}');
      try {
        hours = int.parse('${yyMMddHHP[6]}${yyMMddHHP[7]}');
        minutes = (60 * double.parse('0.${yyMMddHHP[8]}'))
            .round(); // 0.5, 0.8, 1.0, etc.
      } catch (_) {}
      buildDate = DateTime.utc(year, month, day, hours, minutes);
    } catch (_) {}
  }

  /// PackageInfo: appName+version+buildNumber
  ///  - Android: support
  ///  - for iOS/macOS:
  ///   - if CF** keys not defined in info.plist, return null
  ///   - if buildNumber not defined, return version instead
  ///  - Windows: Not Support
  static Future<void> _loadApplicationInfo() async {
    if (_fetchedPackageInfo) return;
    _fetchedPackageInfo = true;
    try {
      final res = await PackageInfo.fromPlatform();
      _packageInfo = res;
      _parseBuildNumber(res.buildNumber);
      packageInfoCompleter.complete(res);
    } catch (_) {
      _fetchedPackageInfo = false;
      Logger.error('get package info error');
    }
  }

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
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

  static bool _debugOn = false;

  static bool get isDebugOn => isDebugDevice || _debugOn;

  static Future<void> _loadUniqueId(String appPath) async {
    final deviceInfoPlugin = DeviceInfoPlugin();
    String? originId;
    if (kIsWeb) {
      // TODO(xieyz): generate uuid then store persistent
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
      // https://stackoverflow.com/a/944103
      // However, IOPlatformUUID will change every boot, use IOPlatformSerialNumber instead
      // ioreg -rd1 -c IOPlatformExpertDevice | awk '/IOPlatformSerialNumber/ { split($0, line, "\""); printf("%s\n", line[4]); }'
      // the filter is shell feature so it's not used
      // Output containing:
      //  "IOPlatformUUID" = "8-4-4-4-12 standard uuid"
      // need to parse output
      originId = (await DeviceInfoPlugin().macOsInfo).systemGUID;
    } else if (kIsLinux) {
      //cat /etc/machine-id
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
      final uuidFile = FilePlus(pathlib.join(appPath, '.uuid'));
      if (uuidFile.existsSync()) {
        originId = await uuidFile.readAsString();
      }
      if (originId?.isNotEmpty != true) {
        originId = const Uuid().v4();
        await uuidFile.writeAsString(originId);
      }
    }
    _uuid = const Uuid().v5(Namespace.url.value, originId).toUpperCase();
    _debugOn = FilePlus(joinPaths(appPath, '.debug')).existsSync();
    Logger.info('Unique ID: $_uuid');
  }

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  static MacAppType _macAppType = MacAppType.unknown;

  static MacAppType get macAppType => _macAppType;

  static bool get isMacStoreApp => _macAppType == MacAppType.store;

  static void _checkMacAppType() {
    if (!kIsMacOS) {
      _macAppType = MacAppType.notMacApp;
    } else {
      final executable = kResolvedExecutable;
      final fpStore = pathlib.absolute(
          pathlib.dirname(executable), '../_MASReceipt/receipt');
      final fpNotarized =
          pathlib.absolute(pathlib.dirname(executable), '../CodeResources');
      if (FilePlus(fpStore).existsSync()) {
        _macAppType = MacAppType.store;
      } else if (FilePlus(fpNotarized).existsSync()) {
        _macAppType = MacAppType.notarized;
      } else {
        _macAppType = MacAppType.debug;
      }
    }
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
    return excludeIds.contains(AppDeviceInfo.uuid);
  }

  static Future<void> resolve(String appPath) async {
    await _loadUniqueId(appPath);
    await _loadDeviceInfo();
    await _loadApplicationInfo();
    _checkMacAppType();
  }

  static void initiateForTest() {
    _uuid = '00000000-0000-0000-0000-000000000000';
    _packageInfo = PackageInfo(
      appName: kAppName,
      packageName: kPackageName,
      version: '9.9.9',
      buildNumber: '9999',
    );
  }

  static String get commitDate => DateFormat.yMd()
      .format(DateTime.fromMillisecondsSinceEpoch(kCommitTimestamp * 1000));
}
