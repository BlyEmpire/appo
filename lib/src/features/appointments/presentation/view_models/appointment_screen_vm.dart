//

import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:appo/src/core/extension/date_time_extension.dart';
import 'package:appo/src/features/appointments/domain/entities/holiday.dart';

enum DateOp { add, subtract }

// enum DeltaUnit { days, months, years }

enum DeltaUnit {
  days(name: "days", intervals: [30, 7, 1, -1]),
  months(name: "months", intervals: [6, 3, 1, -1]),
  years(name: "years", intervals: [10, 5, 1, -1]);

  final String name;
  final List<int> intervals;

  const DeltaUnit({required this.name, required this.intervals});
}

class AppointmentScreenVm extends ChangeNotifier {
  final ZambianHolidayService _holidayService;
  final DateTime _startDate; // injected clock for testability

  // Mutable state
  DateOp _op = DateOp.add;
  int _days = 0;
  int _months = 0;
  int _years = 0;

  DateTime _calculatedDate;
  List<Holiday> _holidaysForYear = [];
  int? _holidaysYear; // the year we last fetched for
  Holiday? _holiday;

  AppointmentScreenVm({
    required ZambianHolidayService zambianHolidayService,
    DateTime? startDate,
  }) : _holidayService = zambianHolidayService,
       _startDate = startDate ?? DateTime.now(),
       _calculatedDate = startDate ?? DateTime.now() {
    _refresh(); // initialize derived state once
  }

  // ===== Getters
  int get days => _days;
  int get months => _months;
  int get years => _years;
  DateOp get operation => _op;

  DateTime get todaysDate => _startDate;
  DateTime get calculatedDate => _calculatedDate;
  Holiday? get holiday => _holiday;
  bool get isHoliday => _holiday != null;

  /// A centered week around `calculatedDate`: [-2, -1, 0, 1, 2]
  List<DateTime> get listWeek => List<DateTime>.generate(
    5,
    (i) => _calculatedDate.add(Duration(days: i - 2)),
  );

  // ===== Public API

  /// Switch between adding or subtracting from the start date.
  void setOperation(DateOp op) {
    if (_op == op) return;
    _op = op;
    _refresh();
  }

  /// Reset all adjustments and go back to the start date.
  void reset() {
    _op = DateOp.add;
    _days = 0;
    _months = 0;
    _years = 0;
    _calculatedDate = _startDate;
    _holiday = null;
    // keep cached holidays; they’ll be reused if same year
    notifyListeners();
  }

  void initialize() => _refresh();

  /// Increment/decrement a unit by `delta` (can be negative).
  /// We clamp to non-negative since the operation (add/subtract) is chosen separately.
  void bump(DeltaUnit unit, int delta) {
    switch (unit) {
      case DeltaUnit.days:
        _days = max(0, _days + delta);
        break;
      case DeltaUnit.months:
        _months = max(0, _months + delta);
        break;
      case DeltaUnit.years:
        _years = max(0, _years + delta);
        break;
    }
    _refresh();
  }

  // ===== Internals

  void _refresh() {
    _recalculateDate();
    _ensureHolidaysForYear(_calculatedDate.year);
    _holiday = _findHolidayOn(_calculatedDate);
    notifyListeners();
  }

  void _recalculateDate() {
    if (_op == DateOp.add) {
      _calculatedDate = _startDate.findNextDate(
        days: _days,
        months: _months,
        years: _years,
      );
    } else {
      _calculatedDate = _startDate.findPreviousDate(
        days: _days,
        months: _months,
        years: _years,
      );
    }
  }

  void _ensureHolidaysForYear(int year) {
    if (_holidaysYear == year && _holidaysForYear.isNotEmpty) return;
    _holidaysForYear = _holidayService.getHolidays(year);
    _holidaysYear = year;
  }

  Holiday? _findHolidayOn(DateTime date) {
    // Try match on actual date first; then observed date if available.
    final byActual = _firstWhereOrNull(
      _holidaysForYear,
      (h) => _isSameDate(_getHolidayDate(h), date),
    );
    if (byActual != null) return byActual;

    final byObserved = _firstWhereOrNull(_holidaysForYear, (h) {
      final observed = _getObservedDate(h);
      return observed != null && _isSameDate(observed, date);
    });
    return byObserved;
  }

  // Helpers to handle potential nulls/different field names in Holiday
  DateTime _getHolidayDate(Holiday h) {
    // Adjust this if your entity uses a different field name
    return h.date;
  }

  DateTime? _getObservedDate(Holiday h) {
    // Adjust this if your entity uses a different field name or is optional
    try {
      return h.date;
    } catch (_) {
      return null;
    }
  }

  bool _isSameDate(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  T? _firstWhereOrNull<T>(Iterable<T> items, bool Function(T) test) {
    for (final item in items) {
      if (test(item)) return item;
    }
    return null;
  }
}
