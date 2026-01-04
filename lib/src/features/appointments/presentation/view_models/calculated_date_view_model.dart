import 'package:appo/src/core/enums/time_unit.dart';
import 'package:appo/src/core/extension/date_time_extension.dart';
import 'package:appo/src/features/appointments/domain/entities/date_calculation.dart';
import 'package:appo/src/features/appointments/domain/entities/time_adjuster.dart';
import 'package:flutter/foundation.dart';

class CalculatedDateViewModel extends ChangeNotifier {
  DateCalculation _calculation = DateCalculation();
  DateTime _startDate = DateTime.now();
  DateTime get startDate => _startDate;

  String get appointmentDate => _calculation.textAppoitmentDate;
  DateTime get calcDate => _calculation.appointmentDate;
  List<DateTime> get weeksDay => _calculation.weekDays();
  bool get isCurrentDateWeekend => calcDate.isWeekend;

  void updateStartDate({required DateTime newDate}) {
    _startDate = newDate;
    notifyListeners();
  }

  void resetStartDate() {
    _startDate = DateTime.now();
    notifyListeners();
  }

  void calculateDate({
    DateTime? startDate,
    DateOperation operation = DateOperation.add,
    TimeAdjuster? adjuster,
  }) {
    _calculation = DateCalculation(
      startDate: startDate,
      operation: operation,
      timeAdjuster: adjuster,
    );

    notifyListeners();
  }
}
