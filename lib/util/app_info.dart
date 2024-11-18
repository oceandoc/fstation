import 'dart:async';

import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
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

class AppInfo extends JsonConverter<AppInfo, String>
    implements Comparable<AppInfo> {
  AppInfo(this.major, this.minor, this.patch, [this.build]);

  /// valid format:
  ///   - v1.2.3+4,'v' and +4 is optional
  ///   - 1.2.3.4, windows format
  AppInfo._internal();

  static final AppInfo _instance = AppInfo._internal();

  static AppInfo get instance => _instance;

  final Map<String, dynamic> appParams = {};
  late final int major;
  late final int minor;
  late final int patch;
  late final int? build;

  late final PackageInfo? _packageInfo;
  bool _fetchedPackageInfo = false;
  final packageInfoCompleter = Completer<PackageInfo>();
  static final RegExp _fullVersionRegex =
      RegExp(r'^v?(\d+)\.(\d+)\.(\d+)(?:[+.](\d+))?$', caseSensitive: false);

  PackageInfo? get packageInfo => _packageInfo;

  String get packageName => packageInfo?.packageName ?? kPackageName;

  bool get isFDroid => kIsAndroid && packageName == kPackageNameFDroid;

  String get appName {
    if (_packageInfo?.appName.isNotEmpty ?? false) {
      return _packageInfo!.appName;
    } else {
      return kAppName;
    }
  }

  String get versionString => _packageInfo?.version ?? '';

  /// e.g. "1.2.3+4"
  String get fullVersion {
    var s = '';
    s += versionString;
    if (buildNumber > 0) s += '+$buildNumber';
    return s;
  }

  int get buildNumber => int.tryParse(_packageInfo?.buildNumber ?? '0') ?? 0;

  Future<void> _loadApplicationInfo() async {
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
      packageInfoCompleter.complete(_packageInfo);

      final Match? match = _fullVersionRegex.firstMatch(versionString);
      if (match != null) {
        major = int.parse(match.group(1)!);
        minor = int.parse(match.group(2)!);
        patch = int.parse(match.group(3)!);
        build = int.tryParse(match.group(4) ?? '');
      }

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
  MacAppType _macAppType = MacAppType.unknown;

  MacAppType get macAppType => _macAppType;

  bool get isMacStoreApp => _macAppType == MacAppType.store;

  void _checkMacAppType() {
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

  Future<void> init() async {
    await _loadApplicationInfo();
    _checkMacAppType();
  }

  void initForTest() {
    _packageInfo = PackageInfo(
      appName: kAppName,
      packageName: kPackageName,
      version: '9.9.9',
      buildNumber: '9999',
    );
  }

  String get commitDate => DateFormat.yMd()
      .format(DateTime.fromMillisecondsSinceEpoch(kCommitTimestamp * 1000));

  static AppInfo parse(String versionString) {
    return tryParse(versionString)!;
  }

  static AppInfo? tryParse(String versionString, [int? build]) {
    final finalVersionString = versionString.trim();
    final Match? match = _fullVersionRegex.firstMatch(finalVersionString);
    if (match == null) return null;
    final major = int.parse(match.group(1)!);
    final minor = int.parse(match.group(2)!);
    final patch = int.parse(match.group(3)!);
    final build = int.tryParse(match.group(4) ?? '');
    return AppInfo(major, minor, patch, build ?? build);
  }

  static int compare(String versionLeft, String versionRight) {
    return AppInfo.parse(versionLeft).compareTo(AppInfo.parse(versionRight));
  }

  bool equalTo(String other) {
    final otherAppInfo = AppInfo.tryParse(other);
    if (otherAppInfo == null) return false;
    if (major == otherAppInfo.major &&
        minor == otherAppInfo.minor &&
        patch == otherAppInfo.patch) {
      return build == null ||
          otherAppInfo.build == null ||
          build == otherAppInfo.build;
    } else {
      return false;
    }
  }

  @override
  int compareTo(AppInfo other) {
    if (major != other.major) return major.compareTo(other.major);
    if (minor != other.minor) return minor.compareTo(other.minor);
    if (patch != other.patch) return patch.compareTo(other.patch);
    return 0;
  }

  bool operator <(AppInfo other) => compareTo(other) < 0;

  bool operator <=(AppInfo other) => compareTo(other) <= 0;

  bool operator >(AppInfo other) => compareTo(other) > 0;

  bool operator >=(AppInfo other) => compareTo(other) >= 0;

  @override
  String toString() {
    return 'AppInfo($major, $minor, $patch${build == null ? "" : ", $build"})';
  }

  @override
  AppInfo fromJson(String json) {
    return AppInfo.tryParse(json) ?? AppInfo(0, 0, 0);
  }

  @override
  String toJson(AppInfo object) {
    return object.versionString;
  }
}
