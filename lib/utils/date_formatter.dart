import 'package:intl/intl.dart';

final dateFormatter = DateFormat('yyyy-d.MMM');
final dayNameFormatter = DateFormat('EEEE');
final dateTimeFormatter = DateFormat("yyyy-MM-dd'T'HH:mm:ss");
final dateWithTimeFormatter = DateFormat('yyyy-MM-dd HH:mm:ss');
final monthYearDateFormatter = DateFormat('MMMM yyyy');
final monthYearShortDateFormatter = DateFormat('MMM yy');
final dayMonthYearDateFormatter = DateFormat('dd-MM-yyyy');
final monthDayYearDateFormatter = DateFormat('MM-dd-yyyy');
final yearMonthDayDateFormatter = DateFormat('yyyy-MM-dd');
final hourMinuteDateFormatter = DateFormat('HH:mm');
final hourMinuteDotDateFormatter = DateFormat('HH.mm');
final completeDateFormatter = DateFormat('EEEE, dd MMMM yyyy');
final regularDateFormatter = DateFormat('dd MMM yyyy');
final monthYearFormatter = DateFormat('MMM yyyy');
final monthFormatter = DateFormat('MM');
final yearFormatter = DateFormat('yyyy');

extension DateTimeStringFormatter on String {
  DateTime get date => dateFormatter.parse(this);

  DateTime get dateTime => dateTimeFormatter.parse(this);

  DateTime get ddMYYYYFormat => dayMonthYearDateFormatter.parse(this);

  DateTime get mMddYYYYFormat => monthDayYearDateFormatter.parse(this);

  DateTime get yyyyMMddFormat => yearMonthDayDateFormatter.parse(this);

  String get month => DateFormat.MMM().format(date);

  String get hourMinuteFormat => hourMinuteDateFormatter.format(dateTime);

  String get regularDateFormat => regularDateFormatter.format(ddMYYYYFormat);

  String get monthYearFormat => monthYearDateFormatter.format(date);

  String get monthYearShortFormat => monthYearShortDateFormatter.format(date);

  String get dayNameFormat => dayNameFormatter.format(ddMYYYYFormat);

  String get dayMonthYearDateFormat => dayMonthYearDateFormatter.format(date);

  String get dayMonthYearFromDateTimeFormat =>
      dayMonthYearDateFormatter.format(dateTime);

  String get dayMonthYearDateFromDateTimeFormat =>
      dayMonthYearDateFormatter.format(dateTime);

  String get monthDayYearDateFromDateTimeFormatter =>
      monthDayYearDateFormatter.format(dateTime);

  String get yearMonthDayFromMonthYear =>
      yearMonthDayDateFormatter.format(monthYearFormatter.parse(this));

  String get regularDateFormatFromYmdHMs =>
      regularDateFormatter.format(dateTime);

  DateTime get yearFormat => yearFormatter.parse(this);
}

extension NullableStringDate on String? {
  String get dMYFormatOrDash =>
      this != null ? this!.dayMonthYearDateFromDateTimeFormat : '-';
}

extension DateTimeFormatter on DateTime {
  String get dayMonthYearDateFormat => dayMonthYearDateFormatter.format(this);

  String get monthDayYearDateFormat => monthDayYearDateFormatter.format(this);

  String get yearMonthDayDateFormat => yearMonthDayDateFormatter.format(this);

  String get hhMMFormat => hourMinuteDateFormatter.format(this);

  String get hhMMdotFormat => hourMinuteDotDateFormatter.format(this);

  String get monthYearFormat => monthYearFormatter.format(this);

  String get completeDayMonthYearFormat => completeDateFormatter.format(this);

  String get regularDateFormat => regularDateFormatter.format(this);

  String get yearFormat => yearFormatter.format(this);

  String get monthFormat => monthFormatter.format(this);

  String get completeDateTimeFormat => dateWithTimeFormatter.format(this);
}
