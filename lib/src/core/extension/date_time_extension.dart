import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  DateTime findNextDate({int days = 0, int months = 0, int years = 0}) {
    return DateTime(year + years, month + months, day + days);
  }

  DateTime findPreviousDate({int days = 0, int months = 0, int years = 0}) {
    return DateTime(year - years, month - months, day - days);
  }

  DateTime restToToday() => DateTime.now();

  String formattedStringDate() {
    return DateFormat("dd MMM yyyy").format(this);
  }

  String weekDayString() {
    return DateFormat("EEE").format(this);
  }
}
