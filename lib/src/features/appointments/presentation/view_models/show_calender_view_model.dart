import 'package:appo/src/core/extension/date_time_extension.dart';
import 'package:flutter/material.dart';

class ShowCalenderViewModel extends ChangeNotifier {
  late DateTime _currentMonth;
  late DateTime _selectedDate;
  late List<DateTime?> _precomputedDays;

  /// constructor: The _currentMonnth and _selectedDate are intialized to the
  /// date at runtime
  ShowCalenderViewModel() {
    final now = DateTime.now();
    _currentMonth = now;
    _selectedDate = now;
    _precomputeDays();
  }

  DateTime get selectedDate => _selectedDate;
  DateTime get currentMonth => _currentMonth;
  List<DateTime?> get precomputedDays => _precomputedDays;

  void _precomputeDays() {
    final lastDay = DateTime(_currentMonth.year, _currentMonth.month + 1, 0);
    final firstDay = DateTime(_currentMonth.year, _currentMonth.month, 1);
    final firstWeekDay = firstDay.weekday;

    final List<DateTime?> days = [];

    // 1. Add leading nulls for empty cells
    for (int i = 1; i < firstWeekDay; i++) {
      days.add(null);
    }

    // 2. Add all days of the month
    for (int i = 1; i <= lastDay.day; i++) {
      days.add(DateTime(_currentMonth.year, _currentMonth.month, i));
    }

    //  3. Trailing empty cells to make total 42 cells
    while (days.length % 7 != 0 || days.length < 42) {
      days.add(null);
    }

    _precomputedDays = days;
  }

  void pickDateOnCalender({required DateTime pickedDate}) {
    _selectedDate = _selectedDate.updateDate(
      newYear: pickedDate.year,
      newMonth: pickedDate.month,
      newDay: pickedDate.day,
    );
    notifyListeners();
  }

  void proceedToNextMonth() {
    _currentMonth = _currentMonth.nextMonth;
    _precomputeDays();

    notifyListeners();
  }

  void proceedToNextYear() {
    _currentMonth = _currentMonth.nextYear;
    _precomputeDays();

    notifyListeners();
  }

  void proceedToPreviousYear() {
    _currentMonth = _currentMonth.previousYear;
    _precomputeDays();

    notifyListeners();
  }

  void proceedToPreviosMonth() {
    _currentMonth = _currentMonth.previousMonth;
    _precomputeDays();

    notifyListeners();
  }

  void get resetStartDate {
    _currentMonth = DateTime.now();
    _selectedDate = DateTime.now();
    notifyListeners();
  }
}
