
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';
import 'constants.dart';
import 'log_color.dart';


mixin LoggerMixin {
  Logger get log => Logger('$runtimeType');
}

/// Adds a listener to the top-level root logger.
void initializeLogger({String? prefix}) {
  if (kReleaseMode || isTest) return;

  Logger.root.level = Level.ALL;

  const separator = ' | ';
  const horizontalSeparator = '--------------------------------';

  Logger.root.onRecord.listen((rec) {
    final content = [
      DateFormat('HH:mm:s.S').format(DateTime.now()),
      separator,
      if (prefix != null) ...[
        prefix,
        separator,
      ],
      rec.level.name.padRight(7),
      separator,
      if (rec.loggerName.isNotEmpty) ...[
        rec.loggerName.padRight(22),
        separator,
      ],
      rec.message,
    ];

    final color = _colorForLevel(rec.level);

    print(color(content.join()));

    if (rec.error != null) {
      print(color(horizontalSeparator));
      print(color('ERROR'));

      if (rec.error is Response) {
        print(color((rec.error! as Response).data));
      } else {
        print(color(rec.error.toString()));
      }

      print(color(horizontalSeparator));

      if (rec.stackTrace != null) {
        print(color('STACK TRACE'));
        for (final line in rec.stackTrace.toString().trim().split('\n')) {
          print(color(line));
        }
        print(color(horizontalSeparator));
      }
    }
  });
}

final _levelColors = {
  Level.FINEST: LogColor.fg(LogColor.grey(0.5)),
  Level.FINER: LogColor.fg(LogColor.grey(0.5)),
  Level.FINE: LogColor.fg(LogColor.grey(0.5)),
  Level.CONFIG: LogColor.fg(12),
  Level.INFO: LogColor.fg(12),
  Level.WARNING: LogColor.fg(208),
  Level.SEVERE: LogColor.fg(196),
  Level.SHOUT: LogColor.fg(199),
};

LogColor _colorForLevel(Level level) {
  return _levelColors[level] ?? LogColor.none();
}
