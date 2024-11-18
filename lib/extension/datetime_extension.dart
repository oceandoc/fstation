extension DateTimeX on DateTime {
  static DateTime? tryParse(String? formattedString) {
    if (formattedString == null) return null;
    final date = DateTime.tryParse(formattedString);
    if (date != null) return date;
    // replace 2020-2-2 0:0 to 2020-02-02 00:00
    final modifiedString = formattedString.replaceFirstMapped(
        RegExp(r'^([+-]?\d{4})-?(\d{1,2})-?(\d{1,2})'), (match) {
      final year = match.group(1)!;
      final month = match.group(2)!.padLeft(2, '0');
      final day = match.group(3)!.padLeft(2, '0');
      return '$year-$month-$day';
    });
    final updatedString = modifiedString
        .replaceFirstMapped(RegExp(r'(\d{1,2}):(\d{1,2})$'), (match) {
      final hour = match.group(1)!.padLeft(2, '0');
      final minute = match.group(2)!.padLeft(2, '0');
      return '$hour:$minute';
    });
    return DateTime.tryParse(updatedString);
  }

  bool checkOutdated(DateTime? dateTime, [Duration? duration]) {
    if (dateTime == null) return false;
    var adjustedDateTime = dateTime;
    if (duration != null) adjustedDateTime = adjustedDateTime.add(duration);
    return isAfter(adjustedDateTime);
  }

  String toStringShort({bool omitSec = false}) {
    return toString().replaceFirstMapped(RegExp(r'(:\d+)(\.\d+)(Z?)'), (match) {
      return omitSec || match.group(1) == ':00'
          ? match.group(3)!
          : match.group(1)! + match.group(3)!;
    });
  }

  String toDateString([String sep = '-']) {
    return [
      year,
      month.toString().padLeft(2, '0'),
      day.toString().padLeft(2, '0')
    ].join(sep);
  }

  String toTimeString({bool seconds = true, bool milliseconds = false}) {
    var output = [hour, minute, if (seconds) second]
        .map((e) => e.toString().padLeft(2, '0'))
        .join(':');
    if (milliseconds) {
      output += '.${millisecond.toString().padLeft(3, "0")}';
    }
    return output;
  }

  String toCustomString(
      {bool year = true, bool second = true, bool millisecond = false}) {
    var output = [
      if (year) this.year,
      month.toString().padLeft(2, '0'),
      day.toString().padLeft(2, '0'),
    ].join('-');
    output += ' ';
    output += [hour, minute, if (second) this.second]
        .map((e) => e.toString().padLeft(2, '0'))
        .join(':');
    if (second && millisecond) {
      output += '.${this.millisecond.toString().padLeft(3, "0")}';
    }
    return output;
  }

  String toSafeFileName([Pattern? pattern]) {
    return toString().replaceAll(pattern ?? RegExp(r'[^\d]'), '_');
  }

  static int compare(DateTime? a, DateTime? b) {
    if (a != null && b != null) {
      return a.compareTo(b);
    } else if (a != null) {
      return 1;
    } else if (b != null) {
      return -1;
    } else {
      return 0;
    }
  }

  int get timestamp => millisecondsSinceEpoch ~/ 1000;
}
