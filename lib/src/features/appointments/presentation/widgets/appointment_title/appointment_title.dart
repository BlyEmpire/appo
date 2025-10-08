import 'package:appo/src/core/constants/colors.dart';
import 'package:appo/src/core/extension/date_time_extension.dart';
import 'package:appo/src/core/utils/responsive.dart';
import 'package:appo/src/features/appointments/presentation/view_models/appointment_screen_vm.dart';
import 'package:appo/src/features/appointments/presentation/widgets/appointment_title/day_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppointmentTitle extends StatefulWidget {
  const AppointmentTitle({super.key});

  @override
  State<AppointmentTitle> createState() => _AppointmentTitleState();
}

class _AppointmentTitleState extends State<AppointmentTitle> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Responsive.init(context: context);
    final viewModel = context.watch<AppointmentScreenVm>();

    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Week day widgets
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: viewModel.listWeek
                  .map((day) => DayWidget(date: day))
                  .toList(),
            ),
          ),

          // Calculated date and holiday info
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  viewModel.calculatedDate.formattedStringDate(),
                  style: TextStyle(
                    fontSize: Responsive.sp(8),
                    fontWeight: FontWeight.bold,
                    color: viewModel.isHoliday ? AppColors.red : Colors.black,
                  ),
                ),
                Text(
                  viewModel.holiday?.name ?? "No Holiday",
                  style: TextStyle(
                    color: viewModel.isHoliday ? AppColors.red : Colors.black,
                    fontWeight: viewModel.isHoliday
                        ? FontWeight.bold
                        : FontWeight.normal,
                    fontSize: Responsive.sp(4),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
