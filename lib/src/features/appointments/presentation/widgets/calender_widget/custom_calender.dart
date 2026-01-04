import 'package:appo/src/features/appointments/presentation/widgets/calender_widget/calender_grid_view.dart';
import 'package:appo/src/features/appointments/presentation/widgets/calender_widget/calender_header_widget.dart';
import 'package:appo/src/features/appointments/presentation/widgets/calender_widget/calender_reset_button.dart';
import 'package:appo/src/features/appointments/presentation/widgets/calender_widget/calender_week_days_list.dart';
import 'package:flutter/material.dart';

class SimpleCalendarPicker extends StatelessWidget {
  final DateTime? initialDate;
  final ValueChanged<DateTime>? onDateSelected;

  const SimpleCalendarPicker({
    super.key,
    this.initialDate,
    this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        spacing: 20.0,
        mainAxisSize: MainAxisSize.min,
        children: const [
          CalenderHeader(),
          CalenderWeekDaysList(),
          CalenderGridView(),
          CalenderResetButtton(),
        ],
      ),
    );
  }
}
