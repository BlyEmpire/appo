import 'dart:math';

import 'package:appo/src/core/enums/time_unit.dart';
import 'package:appo/src/features/appointments/domain/services/zambian_holiday_service.dart';
import 'package:flutter/widgets.dart';
import 'package:appo/src/core/extension/date_time_extension.dart';
import 'package:appo/src/features/appointments/domain/entities/holiday.dart';

class AppointmentScreenVm extends ChangeNotifier {
  static const int _weekWindowSize = 2; // Days before/after center date
  static const int _weekListLength = 5; // Total days in week list

  final ZambianHolidayService _holidayService;

  // Mutable state with clear grouping
  late DateTime _startDate;
  late DateTime _calculatedDate;

  // Date adjustment components
  DateOperation _operation = DateOperation.add;
  int _daysToAdjust = 0;
  int _monthsToAdjust = 0;
  int _yearsToAdjust = 0;

  // Holiday-related state
  List<Holiday> _holidaysForYear = [];
  int? _cachedHolidaysYear;
  Holiday? _currentHoliday;

  AppointmentScreenVm({
    required ZambianHolidayService zambianHolidayService,
    DateTime? startDate,
  }) : _holidayService = zambianHolidayService {
    _initializeState(startDate);
  }

  // ===== Public Getters =====
  int get days => _daysToAdjust;
  int get months => _monthsToAdjust;
  int get years => _yearsToAdjust;
  DateOperation get operation => _operation;
  DateTime get startDate => _startDate;
  DateTime get todaysDate => _startDate;
  DateTime get calculatedDate => _calculatedDate;
  Holiday? get holiday => _currentHoliday;
  bool get isHoliday => _currentHoliday != null;

  /// A centered week around calculatedDate: [-2, -1, 0, 1, 2]
  List<DateTime> get listWeek => List<DateTime>.generate(
    _weekListLength,
    (index) => _calculatedDate.add(Duration(days: index - _weekWindowSize)),
  );

  // ===== Public API =====

  void updateDate({required DateTime newDate}) {
    _startDate = newDate;
    _recalculateAndUpdate();
  }

  void setOperation(DateOperation operation) {
    if (_operation == operation) return;

    _operation = operation;
    _recalculateAndUpdate();
  }

  void reset() {
    _operation = DateOperation.add;
    _daysToAdjust = 0;
    _monthsToAdjust = 0;
    _yearsToAdjust = 0;
    _startDate = DateTime.now();
    _calculatedDate = _startDate;
    _currentHoliday = null;
    // Keep cached holidays for potential reuse

    notifyListeners();
  }

  /// Adjusts a time unit by the given delta (can be positive or negative)
  void adjustTimeUnit(DeltaUnit unit, int delta) {
    switch (unit) {
      case DeltaUnit.days:
        _daysToAdjust = _clampToNonNegative(_daysToAdjust + delta);
        break;
      case DeltaUnit.months:
        _monthsToAdjust = _clampToNonNegative(_monthsToAdjust + delta);
        break;
      case DeltaUnit.years:
        _yearsToAdjust = _clampToNonNegative(_yearsToAdjust + delta);
        break;
    }

    _recalculateAndUpdate();
  }

  // ===== Private Implementation =====

  void _initializeState(DateTime? startDate) {
    final initialDate = startDate ?? DateTime.now();
    _startDate = initialDate;
    _calculatedDate = initialDate;

    _refreshDerivedState();
  }

  void _recalculateAndUpdate() {
    _recalculateDate();
    _refreshDerivedState();
  }

  void _refreshDerivedState() {
    _updateHolidayData();
    _currentHoliday = _findHolidayOnDate(_calculatedDate);

    notifyListeners();
  }

  void _recalculateDate() {
    _calculatedDate = _operation == DateOperation.add
        ? _startDate.findNextDate(
            days: _daysToAdjust,
            months: _monthsToAdjust,
            years: _yearsToAdjust,
          )
        : _startDate.findPreviousDate(
            days: _daysToAdjust,
            months: _monthsToAdjust,
            years: _yearsToAdjust,
          );
  }

  void _updateHolidayData() {
    final targetYear = _calculatedDate.year;

    if (_cachedHolidaysYear == targetYear && _holidaysForYear.isNotEmpty) {
      return; // Already have holidays for this year
    }

    _holidaysForYear = _holidayService.getHolidays(targetYear);
    _cachedHolidaysYear = targetYear;
  }

  Holiday? _findHolidayOnDate(DateTime date) {
    // Check for exact date match first
    final exactMatch = _findHolidayByCondition(
      (holiday) => _datesMatch(_getHolidayDate(holiday), date),
    );

    if (exactMatch != null) return exactMatch;

    // Check for observed date match
    return _findHolidayByCondition((holiday) {
      final observedDate = _getObservedDate(holiday);
      return observedDate != null && _datesMatch(observedDate, date);
    });
  }

  Holiday? _findHolidayByCondition(bool Function(Holiday) condition) {
    for (final holiday in _holidaysForYear) {
      if (condition(holiday)) {
        return holiday;
      }
    }
    return null;
  }

  DateTime _getHolidayDate(Holiday holiday) => holiday.date;

  DateTime? _getObservedDate(Holiday holiday) {
    try {
      return holiday
          .date; // Adjust if your Holiday entity has separate observed date
    } catch (_) {
      return null;
    }
  }

  bool _datesMatch(DateTime date1, DateTime date2) =>
      date1.year == date2.year &&
      date1.month == date2.month &&
      date1.day == date2.day;

  int _clampToNonNegative(int value) => max(0, value);
}

// // Renamed for clarity (assuming you can update the enum name)
// enum DateOperation { add, subtract }
