import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'logger_mixin.dart';

class ErrorHandler with LoggerMixin {

  ErrorHandler({required Future<Widget> Function() builder}) {
    if (kReleaseMode) {
      // override the error widget in release mode (the red error screen)
      ErrorWidget.builder = (details) => const SizedBox();
    }
    FlutterError.onError = _handleFlutterError;
    runZonedGuarded(
      () async {
        runApp(await builder());
      },
      _handleError,
    );
  }

  Future<void> _handleFlutterError(FlutterErrorDetails details) async {
    log.severe('caught flutter error');

    if (kReleaseMode) {
      Zone.current.handleUncaughtError(details.exception, details.stack!);
    } else {
      FlutterError.dumpErrorToConsole(details);
    }
  }

  Future<void> logErrorHandler(Object error, [StackTrace? stackTrace]) async {
    Logger('error handler').info(
      'silently ignoring error',
      error,
      stackTrace,
    );
  }


  /// Prints the error and reports it to sentry in release mode.
  Future<void> _handleError(Object error, StackTrace stackTrace) async {
    if (error is SocketException) {
      // no internet connection, can be ignored
      log.warning(
        'ignoring internet connection error $error',
        error,
        stackTrace,
      );
      return;
    }

    log.warning('caught error', error, stackTrace);

    // final report_crash = SharedPreferences.getInstance().getBool('report_crash') ?? true;
    //
    // if (!report_crash) {
    //   log.info('not reporting error due to missing consent from the user');
    // } else if (kReleaseMode) {
    //   log.info('reporting error to sentry');
    //   try {
    //     await Sentry.captureException(
    //       error,
    //       stackTrace: stackTrace,
    //     ).handleError(logErrorHandler);
    //
    //     log.fine('error reported');
    //   } catch (e, st) {
    //     log.warning('error while reporting error', e, st);
    //   }
    // } else {
    //   log.info('not reporting error in debug / profile mode');
    // }
  } // _handleError
}
