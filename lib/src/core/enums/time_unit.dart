// enum TimeUnit {
//   days(name: "days", intervals: [30, 7, 1, -1]),
//   months(name: "months", intervals: [6, 3, 1, -1]),
//   years(name: "years", intervals: [10, 5, 1, -1]);

//   final String name;
//   final List<int> intervals;

//   const TimeUnit({required this.name, required this.intervals});
// }

/// Operation types for date manipulation
enum DateOperation {
  /// Add to a date (move forward in time)
  add,

  /// Subtract from a date (move backward in time)
  subtract,
}

/// Units for date delta calculations with predefined interval options
///
/// Each unit provides a set of common intervals for quick date adjustments
/// in UI components like date pickers or calendar controls.
enum DeltaUnit {
  /// Day-based intervals with common durations
  days(name: "days", intervals: [30, 7, 1, -1]),

  /// Month-based intervals with common durations
  months(name: "months", intervals: [6, 3, 1, -1]),

  /// Year-based intervals with common durations
  years(name: "years", intervals: [10, 5, 1, -1]);

  /// Display name for the unit (e.g., for UI labels)
  final String name;

  /// Predefined intervals for quick date adjustments
  ///
  /// Positive values represent fixed intervals, while -1 indicates
  /// a custom interval that may require user input.
  /// Examples:
  /// - [30, 7, 1, -1] for days: 30 days, 1 week, 1 day, custom
  /// - [6, 3, 1, -1] for months: 6 months, 3 months, 1 month, custom
  final List<int> intervals;

  const DeltaUnit({required this.name, required this.intervals});

  /// Returns a formatted string representation of a specific interval
  ///
  /// Example:
  /// ```dart
  /// DeltaUnit.days.formatInterval(7) // returns "1 week"
  /// DeltaUnit.months.formatInterval(1) // returns "1 month"
  /// ```
  String formatInterval(int interval) {
    if (interval == -1) return 'Custom';

    switch (this) {
      case DeltaUnit.days:
        return interval == 7 ? '1 week' : '$interval $name';
      case DeltaUnit.months:
      case DeltaUnit.years:
        return '$interval ${interval == 1 ? name.substring(0, name.length - 1) : name}';
    }
  }

  /// Validates if an interval is supported by this unit
  bool isValidInterval(int interval) => intervals.contains(interval);
}

extension DeltaUnitIntervals on DeltaUnit {
  List<int> get intervals {
    switch (this) {
      case DeltaUnit.days:
        return [1, 5, 10, -1]; // -1 for reset/all
      case DeltaUnit.months:
        return [1, 3, 6, -1];
      case DeltaUnit.years:
        return [1, 5, 10, -1];
    }
  }

  String get displayName {
    switch (this) {
      case DeltaUnit.days:
        return 'Days';
      case DeltaUnit.months:
        return 'Months';
      case DeltaUnit.years:
        return 'Years';
    }
  }
}
