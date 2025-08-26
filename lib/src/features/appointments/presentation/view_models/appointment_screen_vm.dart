import 'dart:math';

import 'package:appo/src/core/extension/date_time_extension.dart';
import 'package:flutter/widgets.dart';

class AppointmentScreenVm extends ChangeNotifier {
  // Private State Variables
  final DateTime _startDate = DateTime.now();
  DateTime _calculatedDate = DateTime.now();

  int _days = 0;
  int _months = 0;
  int _years = 0;
  int _index = 1;

  // Getters
  int get days => _days;
  int get months => _months;
  int get years => _years;
  int get index => _index;
  DateTime get todaysDate => _startDate;
  DateTime get calculatedDate => _calculatedDate;
  List<DateTime> get listWeek {
    final calList = [-2, -1, 0, 1, 2];
    return calList
        .map((day) => _calculatedDate.add(Duration(days: day)))
        .toList();
  }

  void activateSubtractionOperation() {
    _index = 0;
    resetDate();
  }

  void activateAdditionOperation() {
    _index = 1;
    resetDate();
  }

  void updateValue({required String type, required int number}) {
    if (type == "days") {
      _days = max(0, _days + number);
    }
    if (type == "months") {
      _months = max(0, _months + number);
    }
    ;
    if (type == "years") {
      _years = max(0, _years + number);
    }
    notifyListeners();
    _reCalculateDate();
  }

  // Actions
  void resetDate() {
    _calculatedDate = DateTime.now();
    _days = 0;
    _months = 0;
    _years = 0;
    notifyListeners();
  }

  void _reCalculateDate() {
    _index == 1 ? _calculateNextDate() : _calculatePreviousDate();
    notifyListeners();
  }

  void _calculateNextDate() {
    _calculatedDate = _startDate.findNextDate(
      days: _days,
      months: _months,
      years: _years,
    );
  }

  void _calculatePreviousDate() {
    _calculatedDate = _startDate.findPreviousDate(
      days: _days,
      months: _months,
      years: _years,
    );
  }
}
