import 'package:equatable/equatable.dart';

/// Represents a public holiday with a name and the date it is observed.
///
/// This class is **immutable** and extends [Equatable] to allow easy
/// comparison between instances.
class Holiday extends Equatable {
  /// The name of the holiday (e.g., "New Year's Day").
  final String _name;

  /// The date on which the holiday is observed.
  final DateTime _observedDate;

  /// Public getter for the holiday name.
  String get name => _name;

  /// Public getter for the observed date of the holiday.
  DateTime get date => _observedDate;

  /// Creates a [Holiday] instance with a [name] and the [observedDate].
  ///
  /// Both fields are required and immutable.
  const Holiday({required String name, required DateTime observedDate})
    : _name = name,
      _observedDate = observedDate;

  /// Overrides [Equatable] props to allow object comparison.
  ///
  /// Two [Holiday] instances are considered equal if both their
  /// `name` and `observedDate` are equal.
  @override
  List<Object?> get props => [_name, _observedDate];

  /// Returns a readable string representation of the holiday.
  ///
  /// Example: "Holiday is New Year's Day and is observed on 2025-01-01 00:00:00.000"
  @override
  String toString() => "Holiday is $name and is observed on $_observedDate";
}
