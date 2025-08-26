import 'package:appo/src/features/appointments/presentation/widgets/buttons_panel.dart';
import 'package:appo/src/features/appointments/presentation/widgets/period_display.dart';
import 'package:appo/src/features/appointments/presentation/widgets/selector.dart';
import 'package:flutter/material.dart';

class AppointmentButtonsGrid extends StatelessWidget {
  const AppointmentButtonsGrid({super.key});

  @override
  Widget build(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [PeriodDisplay(), ButtonsPanel(), SelectorPanel()],
    );
  }
}
