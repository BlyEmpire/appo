import 'package:appo/src/core/extension/build_context_extension.dart';
import 'package:appo/src/shared/shared.dart';
import 'package:appo/src/core/extension/date_time_extension.dart';
import 'package:flutter/material.dart';

class DayWidget extends StatelessWidget {
  final DateTime date;
  final bool isCurrentDate;

  const DayWidget({super.key, required this.date, required this.isCurrentDate});

  @override
  Widget build(BuildContext context) {
    final stlye2 = isCurrentDate
        ? TextStyle(
            fontSize: context.uiBuilder.labelSize,
            fontWeight: FontWeight.bold,
            color: date.isWeekend ? AppColors.primary : Colors.black,
          )
        : TextStyle(
            fontSize: context.uiBuilder.captionSize,
            color: AppColors.textGrey,
          );

    return SizedBox(
      width: context.uiBuilder.dayWidgetSize,
      height: context.uiBuilder.dayWidgetSize,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("${date.day}", style: stlye2),
          Text(date.weekDayString(), style: stlye2),
        ],
      ),
    );
  }
}
