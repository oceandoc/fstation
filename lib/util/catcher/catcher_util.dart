import 'dart:convert';
import 'dart:io';

import 'package:catcher_2/catcher_2.dart';
import 'package:flutter/foundation.dart';
import 'package:fstation/impl/setting_impl.dart';
import 'package:fstation/util/catcher/exception_handler.dart';

import '../../impl/logger.dart';

class CatcherUtil {
  CatcherUtil._();

  static Catcher2Options getOptions() {
    final attachments = <String>[];
    final logPath = Logger.instance.appLogPath;
    if (logPath != null) {
      attachments.add(logPath);
    }

    final feedbackHandler = ExceptionHandler(
      attachments: attachments,
      onGenerateAttachments: () => {
        'settings.memory.json': Uint8List.fromList(
            utf8.encode(jsonEncode(SettingImpl.instance.settings))),
      },
    );

    return Catcher2Options(
      SilentReportMode(),
      [
        if (!kIsWeb && logPath != null) FileHandler(File(logPath)),
        ConsoleHandler(),
        feedbackHandler,
      ],
      handleSilentError: false,
      filterFunction: CatcherUtil.reportFilter,
      handlerTimeout: 12000,
    );
  }

  static bool reportFilter(Report report) {
    return true;
  }

  static void reportError(dynamic error, StackTrace? stacktrace) {
    try {
      Catcher2.getInstance();
      Catcher2.reportCheckedError(error, stacktrace);
    } catch (e) {
      FlutterError.reportError(
          FlutterErrorDetails(exception: error as Object, stack: stacktrace));
    }
  }
}
