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

  String get monthName {
    return DateFormat("MMMM").format(this);
  }

  bool get isWeekend =>
      weekday == DateTime.sunday || weekday == DateTime.saturday;

  // current month extentions functions
  DateTime get firstDay => DateTime(year, month, 1);
  DateTime get lastDay => DateTime(year, month + 1, 0);

  int get daysInMonth => lastDay.day;

  int get firstWeekDay => firstDay.weekday;

  List<DateTime?> get allDays {
    List<DateTime?> allDays = [];
    for (int i = 1; i <= lastDay.day; i++) {
      allDays.add(DateTime(year, month, i));
    }

    for (int i = 1; i < firstWeekDay; i++) {
      allDays.insert(0, null);
    }
    return allDays;
  }

  DateTime get nextMonth => DateTime(year, month + 1, 1);
  DateTime get nextYear => DateTime(year + 1, month, 1);
  DateTime get previousMonth => DateTime(year, month - 1, 1);
  DateTime get previousYear => DateTime(year - 1, month, 1);

  DateTime updateDate({int? newYear, int? newMonth, int? newDay}) {
    return DateTime(newYear ?? year, newMonth ?? month, newDay ?? day);
  }
}
