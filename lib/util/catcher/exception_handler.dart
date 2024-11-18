import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:archive/archive.dart';
import 'package:catcher_2/catcher_2.dart';
import 'package:catcher_2/model/platform_type.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fstation/impl/logger.dart';
import 'package:fstation/util/remote_config.dart';
import 'package:fstation/util/screenshot.dart';
import 'package:path/path.dart' as p;
import 'package:pool/pool.dart';

import '../../generated/git_info.dart';
import '../../generated/l10n.dart';
import '../../impl/router.dart';
import '../app_info.dart';
import '../constants.dart';
import '../device_info.dart';
import '../file_plus/file_plus.dart';
import '../language.dart';
import '../network_util.dart';

// TODO(xieyz): store send timestamp to db, send only once in a week
class ExceptionHandler extends ReportHandler {
  ExceptionHandler({
    this.attachments = const [],
    this.onGenerateAttachments,
    this.sendHtml = true,
    this.printLogs = false,
  });

  final Pool _pool = Pool(1);
  final int _maxEmailCount = 10;
  final List<String> attachments;
  final Map<String, Uint8List> Function()? onGenerateAttachments;
  final bool sendHtml;
  final bool printLogs;
  final HashSet<String> _sentReports = HashSet();

  @override
  List<PlatformType> getSupportedPlatforms() => PlatformType.values;

  @override
  Future<bool> handle(Report report, BuildContext? context) async {
    final screenshotBytes = await Screenshot.instance.capture();
    final generatedAttachments =
        onGenerateAttachments?.call() ?? <String, Uint8List>{};

    return _pool.withResource<bool>(() => _sendMail(report,
        screenshotBytes: screenshotBytes,
        generatedAttachments: generatedAttachments));
  }

  Future<bool> _sendMail(
    Report report, {
    Uint8List? screenshotBytes,
    Map<String, Uint8List> generatedAttachments = const <String, Uint8List>{},
  }) async {
    if (!ConnectivityUtil.instance.hasInternetConnection()) {
      Logger.error(Localization.current.error_no_internet);
      return false;
    }

    if (await _isBlockedError(report)) {
      Logger.info('Blocked Error');
      return true;
    }
    // don't send email repeatedly
    if (_sentReports.contains(report.shownError)) {
      Logger.info('"${report.error}" has been sent before');
      return true;
    }

    if (_sentReports.length > _maxEmailCount) {
      Logger.info(
          'Already reach maximum limit($_maxEmailCount) of sent email, skip');
      return false;
    }

    // wait a moment to let other handlers finish, e.g. FileHandler
    await Future.delayed(const Duration(milliseconds: 300));
    final resolvedAttachments = <String, Uint8List>{};

    final archive = Archive();
    for (final fn in attachments) {
      if (FilePlus(fn).existsSync()) {
        final bytes = await FilePlus(fn).readAsBytes();
        archive.addFile(ArchiveFile(p.basename(fn), bytes.length, bytes));
      }
    }

    for (final entry in generatedAttachments.entries) {
      archive.addFile(ArchiveFile(entry.key, entry.value.length, entry.value));
    }

    List<int>? zippedBytes;
    if (archive.isNotEmpty) {
      zippedBytes = ZipEncoder().encode(archive);
      if (zippedBytes != null) {
        resolvedAttachments['attachment.zip'] = Uint8List.fromList(zippedBytes);
      }
    }

    if (screenshotBytes != null) {
      resolvedAttachments['screenshot.jpg'] = screenshotBytes;
    }

    if (kDebugMode) {
      print('skip sending mail in debug mode');
      return true;
    }

    // TODO(xieyz): send email
    return true;
  }
}

Future<bool> _isBlockedError(Report report) async {
  if (report is FeedbackReport) return false;
  if (report.error is DioException) return true;

  final error = report.shownError;
  final stackTrace = report.stackTrace.toString();
  final errorAndStackTrace = '$error\n$stackTrace';
  if (kIsWeb) {
    if (<Pattern>[
      'TypeError: Failed to fetch',
      'Bad state: Future already completed',
      'Bad state: A RenderObject does not have any constraints before it has been laid out.',
      "NoSuchMethodError: method not found: 'toString' on null",
      'TypeError: Cannot read propert',
      'Null check operator',
      'Bad state: Too many elements',
      'Bad state: No element',
      'Unsupported operation: NaN.floor()',
      "Concurrent modification during iteration: Instance of 'minified",
      RegExp(r'Invalid argument: \d+\.\d+'),
      'Unsupported operation: NaN.round()',
      'Unsupported operation: Infinity.round()',
      'Bad state: RenderBox was not laid out: minified',
    ].any(errorAndStackTrace.contains)) {
      return true;
    }

    if (report.shownError.contains('Stack Overflow') &&
        report.stackTrace.toString().contains('tear_off.<anonymous>')) {
      return true;
    }

    if (RegExp("NoSuchMethodError: method not found: '.+?' on null")
        .hasMatch(errorAndStackTrace)) {
      return true;
    }
  }

  final shouldIgnore = RemoteConfig.instance.blockedErrors
      .any((e) => error.contains(e) || stackTrace.contains(e));
  if (shouldIgnore) {
    Logger.info("don't send blocked error", report.error, report.stackTrace);
    return true;
  }
  return false;
}

Future<String> _setupHtmlMessageText(Report report) async {
  final escape = const HtmlEscape().convert;

  String escapeCode(String s) {
    return '<pre>${escape(s)}</pre>';
  }

  final buffer = StringBuffer()..write('<style>h3{margin:0.2em 0;}</style>');

  if (report is FeedbackReport) {
    if (report.contactInfo?.isNotEmpty ?? false) {
      buffer
        ..write('<h3>Contact:</h3>')
        ..write(escape(report.contactInfo ?? ''))
        ..write('<br/>');
    }

    buffer
      ..write('<h3>Body</h3>')
      ..write(escape(report.body).replaceAll('\n', '<br/>'))
      ..write('<br/><br/>');
  }

  buffer.write('<h3>Summary:</h3>');
  final summary = <String, dynamic>{
    'app':
        '${AppInfo.instance.appName} v${AppInfo.instance.fullVersion} $kCommitHash-${AppInfo.instance.commitDate}',
    'os': '$kOperatingSystem $kOperatingSystemVersion',
    // 'lang': Language.current.code,
    'locale': Language.systemLocale.toString(),
    'uuid': DeviceInfo.uuid,
    // 'user': db.settings.secrets.user?.name ?? "",
    if (kIsWeb)
      // TODO(xieyz): support canvaskit
      'renderer': 'html',
    // 'renderer': kPlatformMethods.rendererCanvasKit ? 'canvaskit' : 'html',
  };
  for (final entry in summary.entries) {
    buffer.write('<b>${entry.key}</b>: ${escape(entry.value.toString())}<br>');
  }
  buffer.write('<hr>');

  if (report is! FeedbackReport) {
    buffer
      ..write('<h3>Error:</h3>')
      ..write(escapeCode(report.error.toString()));
    if (report.error.toString().trim().isEmpty && report.errorDetails != null) {
      buffer.write(escapeCode(report.errorDetails!.exceptionAsString()));
    }
    buffer
      ..write('<hr>')
      ..write('<h3>Stack trace:</h3>');
    final lines = report.stackTrace.toString().split('\n')
      ..removeWhere((e) => e == '<asynchronous suspension>');
    buffer.write(escapeCode(lines.take(20).join('\n')));

    if (report.stackTrace?.toString().trim().isNotEmpty != true &&
        report.errorDetails != null) {
      buffer.write(escapeCode(report.errorDetails!.stack.toString()));
    }
    buffer.write('<hr>');
  }

  buffer.write('<h3>Pages</h3>');
  // Get recent pages from history
  final matchList = router.routerDelegate.currentConfiguration.matches
      .map((match) => match.matchedLocation)
      .take(5)
      .toList();

  for (final path in matchList) {
    buffer..write(escape(path))
      ..write('<br>');
  }
  buffer
    ..write('<hr>')
    ..write('<h3>Device parameters:</h3>');

  for (final entry in report.deviceParameters.entries) {
    buffer.write('<b>${entry.key}</b>: ${escape(entry.value.toString())}<br>');
  }
  buffer
    ..write('<hr>')
    ..write('<h3>Application parameters:</h3>');
  for (final entry in report.applicationParameters.entries) {
    buffer.write('<b>${entry.key}</b>: ${escape(entry.value.toString())}<br>');
  }
  buffer.write('<hr>');

  if (report.customParameters.isNotEmpty) {
    buffer.write('<h3>Custom parameters:</h3>');
    for (final entry in report.customParameters.entries) {
      buffer
          .write('<b>${entry.key}</b>: ${escape(entry.value.toString())}<br>');
    }
    buffer.write('<hr>');
  }

  return buffer.toString();
}

class FeedbackReport extends Report {
  FeedbackReport(this.contactInfo, this.body)
      : super(null, '', DateTime.now(), DeviceInfo.deviceParams,
            AppInfo.instance.appParams, {}, null, PlatformType.unknown, null);
  final String? contactInfo;
  final String body;
}

extension _ReportX on Report {
  String get shownError => (error ?? errorDetails?.exception).toString();
}
