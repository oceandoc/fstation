import 'dart:async';

import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../generated/git_info.dart';
import '../impl/logger.dart';
import 'constants.dart';
import 'file_plus/file_plus.dart';

enum MacAppType {
  unknown,
  store,
  notarized,
  debug,
  notMacApp,
}

class AppInfo {
  static final Map<String, dynamic> appParams = {};
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
      _packageInfo =
          await PackageInfo.fromPlatform().catchError((e) => PackageInfo(
                appName: kAppName,
                packageName: kPackageName,
                version: '0.0.0',
                buildNumber: '0',
              ));

      _parseBuildNumber(_packageInfo!.buildNumber);
      packageInfoCompleter.complete(_packageInfo);
      appParams['version'] = _packageInfo?.version;
      appParams['appName'] = _packageInfo?.appName;
      appParams['buildNumber'] = _packageInfo?.buildNumber;
      appParams['packageName'] = _packageInfo?.packageName;
      appParams['commitHash'] = kCommitHash;
      appParams['commitTimestamp'] = commitDate;
    } catch (_) {
      _fetchedPackageInfo = false;
      Logger.error('get package info error');
    }
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

  static Future<void> init() async {
    await _loadApplicationInfo();
    _checkMacAppType();
  }

  static void initForTest() {
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
