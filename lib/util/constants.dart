import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

final isTest = Platform.environment.containsKey('FLUTTER_TEST');

final kAppKey = GlobalKey<NavigatorState>();
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

// extra
final bool isMobile = isAndroid || isIOS;
final bool isDesktop = isWindows || isMacOS || isLinux;
final bool isDesktopOrWeb = isDesktop || isWeb;
final bool isApple = isIOS || isMacOS;

final String operatingSystem = kIsWeb ? 'browser' : Platform.operatingSystem;
final String operatingSystemVersion =
    kIsWeb ? '' : Platform.operatingSystemVersion;
final String resolvedExecutable = kIsWeb
    ? throw UnimplementedError('Not for web')
    : Platform.resolvedExecutable;

bool get isTargetMobile => [TargetPlatform.android, TargetPlatform.iOS]
    .contains(defaultTargetPlatform);

bool get isTargetDesktop => !isTargetMobile;

final bool supportCopyImage =
    kIsWeb || Platform.isIOS || Platform.isMacOS || Platform.isWindows;

