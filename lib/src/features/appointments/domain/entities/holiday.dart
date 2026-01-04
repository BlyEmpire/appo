import 'package:equatable/equatable.dart';

/// Represents a public holiday with a name and the date it is observed.
///
/// This class is *immutable* and extends [Equatable] to allow easy
/// comparison between instances.
class Holiday extends Equatable {
  final String _name;
  final DateTime _observedDate;

  String get name => _name;
  DateTime get date => _observedDate;

  const Holiday({required String name, required DateTime observedDate})
    : _name = name,
      _observedDate = observedDate;

  @override
  List<Object?> get props => [_name, _observedDate];

  @override
  String toString() => "Holiday is $name and is observed on $_observedDate";
}
