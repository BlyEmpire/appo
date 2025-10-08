import 'package:appo/src/core/enums/time_unit.dart';
import 'package:appo/src/features/appointments/presentation/view_models/appointment_screen_vm.dart';
import 'package:appo/src/features/appointments/presentation/widgets/buttons_panel/panel_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TimeUnitButtonColumn extends StatelessWidget {
  final DeltaUnit deltaUnit;

  const TimeUnitButtonColumn({super.key, required this.deltaUnit});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<AppointmentScreenVm>();

    return Column(
      children: deltaUnit.intervals.map((value) {
        return PanelButton(
          value: value,
          isResetButton: value < 0,
          onPressed: () => viewModel.adjustTimeUnit(deltaUnit, value),
          // number: null,
          // isLast: null,
        );
      }).toList(),
    );
  }
}
