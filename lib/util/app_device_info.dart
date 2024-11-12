import 'dart:async';
import 'dart:io';

import 'package:android_id/android_id.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:fstation/util/extensions.dart';
import 'package:fstation/util/util.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path/path.dart' as pathlib;
import 'package:uuid/uuid.dart';

import '../generated/git_info.dart';
import '../impl/logger.dart';
import 'file_plus/file_plus.dart';
import 'app_method_channel.dart';

enum MacAppType {
  unknown,
  store,
  notarized,
  debug,
  notMacApp,
}

final kAppKey = GlobalKey<NavigatorState>();
const kCurrentDBVersion = 1;
final isTest = Platform.environment.containsKey('FLUTTER_TEST');
const String kAppName = 'FastStation';
const String kPackageName = 'com.xiedeacc.fstation';
const String kPackageNameFDroid = 'com.xiedeacc.fstation.fdroid';
const bool isWeb = kIsWeb;
final bool isLinux = !kIsWeb && Platform.isLinux;
final bool isMacOS = !kIsWeb && Platform.isMacOS;
final bool isWindows = !kIsWeb && Platform.isWindows;
final bool isAndroid = !kIsWeb && Platform.isAndroid;
final bool isIOS = !kIsWeb && Platform.isIOS;
final bool isFuchsia = !kIsWeb && Platform.isFuchsia;
final bool isMobile = isAndroid || isIOS;
final bool isDesktop = isWindows || isMacOS || isLinux;
final bool isDesktopOrWeb = isDesktop || isWeb;
final bool isApple = isIOS || isMacOS;
final String kOperatingSystem = kIsWeb ? 'browser' : Platform.operatingSystem;
final String kOperatingSystemVersion =
    kIsWeb ? '' : Platform.operatingSystemVersion;
final String kResolvedExecutable = kIsWeb ? '' : Platform.resolvedExecutable;
final bool kSupportCopyImage =
    kIsWeb || Platform.isIOS || Platform.isMacOS || Platform.isWindows;

bool get isTargetMobile => [TargetPlatform.android, TargetPlatform.iOS]
    .contains(defaultTargetPlatform);

bool get isTargetDesktop => !isTargetMobile;

final bool supportCopyImage =
    kIsWeb || Platform.isIOS || Platform.isMacOS || Platform.isWindows;
const bool supportScreenshot = !kIsWeb && true;

class AppDeviceInfo {
  AppDeviceInfo._();

  static String? _deviceId;

  static String? get deviceId => _deviceId;
  static PackageInfo? _packageInfo;
  static String? _uuid;
  static bool _debugOn = false;
  static MacAppType _macAppType = MacAppType.unknown;
  static bool _isIPad = false;

  static bool get isIPad => _isIPad;
  static int? _androidSdk;

  static int? get androidSdk => _androidSdk;
  static final Map<String, dynamic> deviceParams = {};
  static final Map<String, dynamic> appParams = {};
  static final androidInfoCompleter = Completer<AndroidDeviceInfo>();
  static final packageInfoCompleter = Completer<PackageInfo>();
  static AndroidDeviceInfo? androidInfo;
  static PackageInfo? packageInfo;
  static String? version;
  static DateTime? buildDate;
  static String? buildType;
  static bool _fetchedAndroidInfo = false;
  static bool _fetchedPackageInfo = false;

  static Future<void> fetchAndroidInfo() async {
    if (_fetchedAndroidInfo) return;
    _fetchedAndroidInfo = true;
    try {
      final res = await DeviceInfoPlugin().androidInfo;
      androidInfo = res;
      androidInfoCompleter.complete(res);
    } catch (_) {
      _fetchedAndroidInfo = false;
    }
  }

  static Future<void> fetchDeviceId() async {
    if (_deviceId != null) return;
    _deviceId = await FlutterUdid.udid;
  }

  static Future<void> fetchPackageInfo() async {
    if (_fetchedPackageInfo) return;
    _fetchedPackageInfo = true;
    try {
      final res = await PackageInfo.fromPlatform();
      packageInfo = res;
      version = res.version;
      _parseBuildNumber(res.buildNumber);
      packageInfoCompleter.complete(res);
    } catch (_) {
      _fetchedPackageInfo = false;
    }
  }

  static String get packageName => info?.packageName ?? kPackageName;

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

  static Future<void> _loadDeviceInfo() async {
    try {
      if (isAndroid) {
        final androidInfo = await DeviceInfoPlugin().androidInfo;
        deviceParams
            .addAll(Map.from(androidInfo.data)..remove('systemFeatures'));
        _androidSdk = androidInfo.version.sdkInt;
        deviceParams['androidId'] = await const AndroidId().getId();
        deviceParams['userAgent'] = await AppMethodChannel.getUserAgent();
      } else if (isIOS) {
        final iosInfo = await DeviceInfoPlugin().iosInfo;
        _isIPad = iosInfo.model.toLowerCase().contains('ipad');
        deviceParams.addAll(Map.from(iosInfo.data)..remove('name'));
        deviceParams['CFNetworkVersion'] =
            await AppMethodChannel.getCFNetworkVersion();
      } else if (isMacOS) {
        final macOsInfo = await DeviceInfoPlugin().macOsInfo;
        deviceParams.addAll(Map.from(macOsInfo.data)..remove('computerName'));
      } else if (isLinux) {
        final linuxInfo = await DeviceInfoPlugin().linuxInfo;
        deviceParams.addAll(Map.from(linuxInfo.data));
      } else if (isWindows) {
        final windowsInfo = await DeviceInfoPlugin().windowsInfo;
        deviceParams
            .addAll(Map.from(windowsInfo.data)..remove('digitalProductId'));
      } else if (isWeb) {
        final webInfo = await DeviceInfoPlugin().webBrowserInfo;
        deviceParams.addAll({
          ...webInfo.data,
          'browserName': webInfo.browserName.name,
        });
      } else {
        deviceParams['operatingSystem'] = kOperatingSystem;
        deviceParams['operatingSystemVersion'] =
            kOperatingSystemVersion;
      }
    } catch (e, s) {
      Logger.error('failed to load device info', e, s);
      deviceParams['failed'] = e.toString();
    }
  }

  /// PackageInfo: appName+version+buildNumber
  ///  - Android: support
  ///  - for iOS/macOS:
  ///   - if CF** keys not defined in info.plist, return null
  ///   - if buildNumber not defined, return version instead
  ///  - Windows: Not Support
  static Future<void> _loadApplicationInfo() async {
    ///Only android, iOS and macOS are implemented
    _packageInfo =
        await PackageInfo.fromPlatform().catchError((e) => PackageInfo(
              appName: kAppName,
              packageName: kPackageName,
              version: '0.0.0',
              buildNumber: '0',
            ));
    _packageInfo = PackageInfo(
      appName: _packageInfo!.appName.toTitle(),
      packageName: _packageInfo!.packageName,
      version: _packageInfo!.version,
      buildNumber: _packageInfo!.buildNumber,
    );
    appParams['version'] = _packageInfo?.version;
    appParams['appName'] = _packageInfo?.appName;
    appParams['buildNumber'] = _packageInfo?.buildNumber;
    appParams['packageName'] = _packageInfo?.packageName;
    appParams['commitHash'] = kCommitHash;
    appParams['commitTimestamp'] = commitDate;
  }

  static Future<void> _loadUniqueId(String appPath) async {
    final deviceInfoPlugin = DeviceInfoPlugin();
    String? originId;
    if (isWeb) {
      // // use generated uuid
      // originId = null;
      // _uuid = '00000000-0000-0000-0000-000000000000';
      // return;
    } else if (isAndroid) {
      originId = await const AndroidId().getId();
    } else if (isIOS) {
      originId = (await deviceInfoPlugin.iosInfo).identifierForVendor;
    } else if (isWindows) {
      // reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v "ProductId"
      // Output:
      // HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion
      //     ProductId    REG_SZ    XXXXX-XXXXX-XXXXX-XXXXX
      final result = await Process.run(
        'reg',
        [
          'query',
          // ProductId
          // r'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion',
          // MachineGuid
          r'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Cryptography',
          '/v',
          // 'ProductId'
          'MachineGuid'
        ],
        runInShell: true,
      );
      final resultString = result.stdout.toString().trim();
      // print('Windows MachineGuid query:\n$resultString');
      if (resultString.contains('MachineGuid') &&
          resultString.contains('REG_SZ')) {
        originId = resultString.trim().split(RegExp(r'\s+')).last;
      }
    } else if (isMacOS) {
      // https://stackoverflow.com/a/944103
      // However, IOPlatformUUID will change every boot, use IOPlatformSerialNumber instead
      // ioreg -rd1 -c IOPlatformExpertDevice | awk '/IOPlatformSerialNumber/ { split($0, line, "\""); printf("%s\n", line[4]); }'
      // the filter is shell feature so it's not used
      // Output containing:
      //  "IOPlatformUUID" = "8-4-4-4-12 standard uuid"
      // need to parse output
      originId = (await DeviceInfoPlugin().macOsInfo).systemGUID;
    } else if (isLinux) {
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

  static void initiateForTest() {
    _uuid = '00000000-0000-0000-0000-000000000000';
    _packageInfo = PackageInfo(
      appName: kAppName,
      packageName: kPackageName,
      version: '9.9.9',
      buildNumber: '9999',
    );
  }

  static Future<void> resolve(String appPath) async {
    await _loadUniqueId(appPath);
    await _loadDeviceInfo();
    await _loadApplicationInfo();
    _checkMacAppType();
  }

  static void _checkMacAppType() {
    if (!isMacOS) {
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

  static PackageInfo? get info => _packageInfo;

  static String get appName {
    if (_packageInfo?.appName.isNotEmpty ?? false) {
      return _packageInfo!.appName;
    } else {
      return kAppName;
    }
  }

  static String get commitDate => DateFormat.yMd()
      .format(DateTime.fromMillisecondsSinceEpoch(kCommitTimestamp * 1000));

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

  static String get uuid => _uuid ?? '----';

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

  static bool get isDebugOn => isDebugDevice || _debugOn;

  static MacAppType get macAppType => _macAppType;

  static bool get isMacStoreApp => _macAppType == MacAppType.store;

  static bool get isFDroid => isAndroid && packageName == kPackageNameFDroid;
}
