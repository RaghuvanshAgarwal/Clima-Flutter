class TimeHelper {
  final DateTime? dateTime;

  TimeHelper(String? dateTimeString)
    : dateTime = dateTimeString != null
          ? DateTime.tryParse(dateTimeString.replaceFirst(' ', 'T'))
          : null;

  static const _weekdays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  static const _months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  /// e.g. "Sunday", or '' if input was null/invalid
  String get dayOfWeek {
    final dt = dateTime;
    if (dt == null) return '';
    return _weekdays[dt.weekday - 1];
  }

  /// e.g. "Sun", or '' if input was null/invalid
  String get dayOfWeekShort =>
      dayOfWeek.isEmpty ? '' : dayOfWeek.substring(0, 3);

  /// e.g. "12 AM", or '' if input was null/invalid
  String get formattedTime {
    final dt = dateTime;
    if (dt == null) return '';
    final hour24 = dt.hour;
    final period = hour24 >= 12 ? 'PM' : 'AM';
    final hour12 = hour24 % 12 == 0 ? 12 : hour24 % 12;
    return '$hour12 $period';
  }

  /// e.g. "July 5, 2026", or '' if input was null/invalid
  String get formattedDate {
    final dt = dateTime;
    if (dt == null) return '';
    return '${_months[dt.month - 1]} ${dt.day}, ${dt.year}';
  }

  /// e.g. "6:59 PM", or '' if input was null/invalid
  String get formattedTimeWithMinutes {
    final dt = dateTime;
    if (dt == null) return '';
    final hour24 = dt.hour;
    final period = hour24 >= 12 ? 'PM' : 'AM';
    final hour12 = hour24 % 12 == 0 ? 12 : hour24 % 12;
    final minute = dt.minute.toString().padLeft(2, '0');
    return '$hour12:$minute $period';
  }

  /// true if the string was successfully parsed
  bool get isValid => dateTime != null;
}
