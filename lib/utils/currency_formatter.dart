import 'package:intl/intl.dart';
import '../commons/tuple.dart';

final formatCurrency = NumberFormat.currency(
  locale: 'id',
  symbol: 'Rp ',
  decimalDigits: 0,
);

final decimalFormatterTwoDigitBehind = NumberFormat('#,###.00', 'id_ID');
final decimalFormatter = NumberFormat('#,###', 'id_ID');

final decimalFormatterCommaTwoDigit = NumberFormat('#,###.00');

final decimalFormatPercent =
    NumberFormat.decimalPercentPattern(decimalDigits: 2, locale: 'id_ID');

extension Currency on double {
  String get currencyFormat => formatCurrency.format(this);

  String get decimalTwoDigitBehind =>
      this == 0.00000000 ? '0.00' : decimalFormatterTwoDigitBehind.format(this);

  String get decimalCommaTwoDigitBehind =>
      this == 0.00000000 ? '0.00' : decimalFormatterCommaTwoDigit.format(this);

  String get decimalFormat => decimalFormatter.format(this);

  String get idFormat => currencyFormat;

  String get percentFormat => '$this%';

  String get percentFormatTwoDigit => '$decimalTwoDigitBehind%';

  String get percentRealFormatTwoDigit =>
      this == 0.00000000 ? '0,00%' : decimalFormatPercent.format(this);

  /// return shorter version of money.
  /// e.g: 7,923,222 become 7,9M
  Tuple<double, String> short() {
    if (this > 999 && this < 99999) {
      return Tuple(double.parse((this / 1000).toStringAsFixed(0)), 'K');
    } else if (this > 99999 && this < 999999) {
      return Tuple(double.parse((this / 1000).toStringAsFixed(0)), 'K');
    } else if (this > 999999 && this < 999999999) {
      return Tuple(double.parse((this / 1000000).toStringAsFixed(0)), 'M');
    } else if (this > 999999999) {
      return Tuple(double.parse((this / 1000000000).toStringAsFixed(0)), 'B');
    } else {
      return Tuple(this, '');
    }
  }

  String get shortToString {
    var shortVersion = short();
    return '${shortVersion.first.toInt()}${shortVersion.second}';
  }
}

extension ShortInt on int {
  String short() {
    if (this > 999 && this < 99999) {
      return '${(this / 1000).toStringAsFixed(0)}K';
    } else if (this > 99999 && this < 999999) {
      return '${(this / 1000).toStringAsFixed(0)}K';
    } else if (this > 999999 && this < 999999999) {
      return '${(this / 1000000).toStringAsFixed(0)}M';
    } else if (this > 999999999) {
      return '${(this / 1000000000).toStringAsFixed(0)}B';
    } else {
      return toString();
    }
  }
}

extension NullableDoubleCurrency on double? {
  String get idFormatOrDash => this != null ? this!.idFormat : '-';
  String get decimalTwoDigit =>
      this != null ? this!.decimalTwoDigitBehind : '-';
  String get decimalRounded => this != null ? this!.decimalFormat : '-';
}
