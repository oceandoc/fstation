import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'platform/platform_native.dart'
    if (dart.library.js) 'platform/platform_web.dart';

const url = r'https?://([\w-]+\.)+[\w-]+(/[\w-./?%&@\$=~#+]*)?';
const phoneNumber = r'[+0]\d+[\d-]+\d';
const email = r'[^@\s]+@([^@\s]+\.)+[^@\W]+';
const duration = r'\b(\d{1,2}:)?(\d{1,2}):(\d{2})\b';
const all = '($url|$duration|$phoneNumber|$email)';

final kIsTest = Platform.environment.containsKey('FLUTTER_TEST');
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

final kAppKey = GlobalKey<NavigatorState>();

final kPlatformMethods = PlatformMethods();
final bool supportScreenshot = !kIsWeb || kPlatformMethods.rendererCanvasKit;
