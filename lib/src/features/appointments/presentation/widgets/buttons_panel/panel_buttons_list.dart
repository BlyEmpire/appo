import 'package:appo/src/core/enums/time_unit.dart';
import 'package:appo/src/features/appointments/presentation/view_models/calculated_date_view_model.dart';
import 'package:appo/src/features/appointments/presentation/view_models/panel_manager.dart';
import 'package:appo/src/features/appointments/presentation/view_models/selector_view_model.dart';
import 'package:appo/src/features/appointments/presentation/view_models/show_calender_view_model.dart';
import 'package:appo/src/features/appointments/presentation/widgets/buttons_panel/panel_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PanelButtonList extends StatelessWidget {
  final TimeUnit timeUnit;

  const PanelButtonList({super.key, required this.timeUnit});

  @override
  Widget build(BuildContext context) {
    final panelManager = context.read<PanelManager>();
    final dateManager = context.read<CalculatedDateViewModel>();
    final selectorManager = context.read<SelectorViewModel>();
    final calenderManager = context.read<ShowCalenderViewModel>();

    return Column(
      children: timeUnit.intervals.map((number) {
        return PanelButton(
          number: number,
          onPressed: () => _handleButtonPress(
            number: number,
            panelManager: panelManager,
            dateManager: dateManager,
            selectorManager: selectorManager,
            calenderManager: calenderManager,
          ),
        );
      }).toList(),
    );
  }

  void _handleButtonPress({
    required int number,
    required PanelManager panelManager,
    required CalculatedDateViewModel dateManager,
    required SelectorViewModel selectorManager,
    required ShowCalenderViewModel calenderManager,
  }) {
    // update the time adjuster
    panelManager.updateTimeAdjuster(timeUnit: timeUnit, number: number);

    // get the time adjuster
    final adjuster = panelManager.timeAdjuster;

    // get the current operation
    final operation = selectorManager.currentOperation;

    // calculate the date
    dateManager.calculateDate(
      startDate: calenderManager.selectedDate,
      operation: operation,
      adjuster: adjuster,
    );
  }
}
