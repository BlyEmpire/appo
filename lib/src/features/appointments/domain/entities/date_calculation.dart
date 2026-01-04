import 'package:appo/src/core/enums/time_unit.dart';
import 'package:appo/src/core/extension/date_time_extension.dart';
import 'package:appo/src/features/appointments/domain/entities/time_adjuster.dart';

class DateCalculation {
  final DateTime _startDate;
  final DateOperation _operation;
  final TimeAdjuster _timeAdjuster;

  DateCalculation({
    DateTime? startDate,
    DateOperation operation = DateOperation.add,
    TimeAdjuster? timeAdjuster,
  }) : _startDate = startDate ?? DateTime.now(),
       _operation = operation,
       _timeAdjuster = timeAdjuster ?? TimeAdjuster();

  DateTime get appointmentDate {
    return _operation == DateOperation.add
        ? _startDate.findNextDate(
            days: _timeAdjuster.days,
            months: _timeAdjuster.months,
            years: _timeAdjuster.years,
          )
        : _startDate.findPreviousDate(
            days: _timeAdjuster.days,
            months: _timeAdjuster.months,
            years: _timeAdjuster.years,
          );
  }

  List<DateTime> weekDays({int days = 5}) {
    if (days.isEven) {
      throw Exception("only odd numbers are allowed");
    }

    List<DateTime> mappedWeek = [];

    final mid = days ~/ -2;
    final last = List.generate(days, (e) => mid + e).last;

    for (var i = mid; i <= last; i++) {
      final newDate = appointmentDate.add(Duration(days: i));
      mappedWeek.add(newDate);
    }

    return mappedWeek;
  }

  String get textAppoitmentDate => appointmentDate.formattedStringDate();
  String get textStartDate => _startDate.formattedStringDate();

  Map<int, DateTime> generateWeekDays({int days = 5}) {
    Map<int, DateTime> mappedDays = {};

    final mid = days ~/ -2;
    final last = List.generate(days, (e) => mid + e).last;

    for (var i = mid; i <= last; i++) {
      final newDate = appointmentDate.add(Duration(days: i));
      mappedDays[i + 2] = newDate;
    }

    return mappedDays;
  }
}
