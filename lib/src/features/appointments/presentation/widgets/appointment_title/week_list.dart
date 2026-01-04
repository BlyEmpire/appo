import 'package:appo/src/features/appointments/presentation/widgets/appointment_title/day_widget.dart';
import 'package:flutter/material.dart';

class WeekDayList extends StatelessWidget {
  const WeekDayList({super.key, required this.weekDays});

  final List<DateTime> weekDays;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: weekDays.map((day) {
        bool isCurrentDate = weekDays.indexOf(day) == 2;
        return DayWidget(date: day, isCurrentDate: isCurrentDate);
      }).toList(),
    );
  }
}
