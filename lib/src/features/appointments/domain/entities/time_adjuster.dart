import 'package:appo/src/core/enums/time_unit.dart';
import 'package:equatable/equatable.dart';

/// The [TimeAdjuster] class defines the time units than can be adjusted.
///
/// This is used in the panel where a button can be pressed and changes the
/// time adjust properties based on a passed value.
///
/// It contains the following funnctions;
/// 1. [add] - can add the days, months or years
/// 2. [subtract] -  can subtract the days, months or years,
/// 3. [reset] - used to reset a time adjust to default days = 0, months = 0 and years = 0.
class TimeAdjuster extends Equatable {
  final int _days;
  final int _months;
  final int _years;

  TimeAdjuster({int days = 0, int months = 0, int years = 0})
    : _days = days.clamp(0, 500),
      _months = months.clamp(0, 100),
      _years = years.clamp(0, 100);

  // ----- Getters -----
  int get days => _days;
  int get months => _months;
  int get years => _years;

  TimeAdjuster update({int? days, int? months, int? years}) {
    return TimeAdjuster(
      days: _days + (days ?? 0),
      months: _months + (months ?? 0),
      years: _years + (years ?? 0),
    );
  }

  TimeAdjuster reset() {
    return TimeAdjuster(days: 0, months: 0, years: 0);
  }

  String getValueFromUnit({required TimeUnit unit}) {
    switch (unit) {
      case TimeUnit.days:
        return "$days";
      case TimeUnit.months:
        return "$months";
      case TimeUnit.years:
        return "$years";
    }
  }

  @override
  List<Object?> get props => [_days, _months, _years];
}
