import 'package:appo/src/core/enums/time_unit.dart';
import 'package:appo/src/features/appointments/domain/entities/time_adjuster.dart';
import 'package:flutter/material.dart';

/// The PanelManger coordinates the update of the [TimeAdjuster] that is used
/// to calculate the next appoinment date.
class PanelManager extends ChangeNotifier {
  TimeAdjuster _timeAdjuster = TimeAdjuster();
  TimeAdjuster get timeAdjuster => _timeAdjuster;

  void resetTime() {
    if (_timeAdjuster == TimeAdjuster()) return;
    _timeAdjuster = _timeAdjuster.reset();
    debugPrint(
      "The time adjuster has been reseted with days: ${timeAdjuster.days} months: ${timeAdjuster.months} years: ${timeAdjuster.years}",
    );
    notifyListeners();
  }

  void updateTimeAdjuster({required TimeUnit timeUnit, required int number}) {
    switch (timeUnit) {
      case TimeUnit.days:
        _timeAdjuster = _timeAdjuster.update(days: number);
        break;
      case TimeUnit.months:
        _timeAdjuster = _timeAdjuster.update(months: number);
        break;
      case TimeUnit.years:
        _timeAdjuster = _timeAdjuster.update(years: number);
        break;
    }
    debugPrint(
      "The time adjuster has been updated with days: ${timeAdjuster.days} months: ${timeAdjuster.months} years: ${timeAdjuster.years}",
    );
    notifyListeners();
  }
}
