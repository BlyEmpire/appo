import 'package:appo/src/core/constants/colors.dart';
import 'package:appo/src/core/extension/date_time_extension.dart';
import 'package:appo/src/core/utils/responsive.dart';
import 'package:appo/src/features/appointments/presentation/view_models/appointment_screen_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
    context.read<AppointmentScreenVm>().initialize();
  }

  @override
  Widget build(BuildContext context) {
    Responsive.init(context: context);
    final vm = context.watch<AppointmentScreenVm>();
    return FractionallySizedBox(
      widthFactor: 0.8,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: vm.listWeek
                    .map((day) => DayWidget(date: day))
                    .toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    vm.calculatedDate.formattedStringDate(),
                    style: TextStyle(
                      fontSize: Responsive.sp(8),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(vm.holiday?.name ?? "No Holiday"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DayWidget extends StatelessWidget {
  final DateTime date;
  const DayWidget({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    Responsive.init(context: context);
    final vm = context.watch<AppointmentScreenVm>();
    // text style if date is calculate
    TextStyle style = date == vm.calculatedDate
        ? TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0)
        : TextStyle(color: AppColors.gray);
    return SizedBox(
      width: 40.0,
      height: 40.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("${date.day}", style: style),
          Text(date.weekDayString(), style: style),
        ],
      ),
    );
  }
}
