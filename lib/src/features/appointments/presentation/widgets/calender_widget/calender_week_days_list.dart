// import 'package:appo/src/core/extension/build_context_extension.dart';
import 'package:flutter/material.dart';

class CalenderWeekDaysList extends StatelessWidget {
  const CalenderWeekDaysList({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(child: _BuildWeekdayItem(weekday: "Mo")),
        Expanded(child: _BuildWeekdayItem(weekday: "Tu")),
        Expanded(child: _BuildWeekdayItem(weekday: "We")),
        Expanded(child: _BuildWeekdayItem(weekday: "Th")),
        Expanded(child: _BuildWeekdayItem(weekday: "Fr")),
        Expanded(child: _BuildWeekdayItem(weekday: "Sa")),
        Expanded(child: _BuildWeekdayItem(weekday: "Su")),
      ],
    );
  }
}

class _BuildWeekdayItem extends StatelessWidget {
  const _BuildWeekdayItem({required this.weekday});

  final String weekday;

  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context).size.width;
    final fontSize = query < 600 ? 14.0 : 18.0;
    return Center(
      child: Text(
        weekday,
        style: TextStyle(fontSize: fontSize, color: Colors.grey),
      ),
    );
  }
}
