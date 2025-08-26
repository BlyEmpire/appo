import 'package:equatable/equatable.dart';

class Holiday extends Equatable {
  final int id;
  final String name;
  final DateTime actualDate;
  final DateTime observedDate;

  const Holiday({
    required this.id,
    required this.name,
    required this.actualDate,
    required this.observedDate,
  });

  @override
  List<Object?> get props => [id, name, actualDate, observedDate];
}
