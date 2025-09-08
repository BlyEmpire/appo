import 'package:appo/src/core/enums/time_unit.dart';
import 'package:appo/src/core/utils/responsive.dart';
import 'package:appo/src/features/appointments/presentation/view_models/appointment_screen_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PeriodDisplay extends StatelessWidget {
  const PeriodDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppointmentScreenVm>();
    return InkWell(
      onTap: () => vm.reset(),
      child: Container(
        margin: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Color(0x16363535),
              blurRadius: 26,
              offset: Offset(0, 20),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TimeWidget(name: TimeUnit.days.name, time: vm.days),
            TimeWidget(name: TimeUnit.months.name, time: vm.months),
            TimeWidget(name: TimeUnit.years.name, time: vm.years),
          ],
        ),
      ),
    );
  }
}

class TimeWidget extends StatelessWidget {
  final String name;
  final int time;
  const TimeWidget({super.key, required this.name, required this.time});

  @override
  Widget build(BuildContext context) {
    Responsive.init(context: context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(name, style: TextStyle(fontSize: Responsive.sp(3))),
          Text(
            "$time",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: Responsive.sp(5),
            ),
          ),
        ],
      ),
    );
  }
}
