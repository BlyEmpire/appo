import 'package:appo/src/features/appointments/presentation/widgets/buttons_panel/panel_buttons_list.dart';
import 'package:appo/src/core/enums/time_unit.dart';
import 'package:flutter/material.dart';

class ButtonsPanel extends StatelessWidget {
  const ButtonsPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return const FractionallySizedBox(
      widthFactor: 0.8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          PanelButtonList(timeUnit: TimeUnit.days),
          PanelButtonList(timeUnit: TimeUnit.months),
          PanelButtonList(timeUnit: TimeUnit.years),
        ],
      ),
    );
  }
}
