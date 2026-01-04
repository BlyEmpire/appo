import 'package:appo/src/core/enums/time_unit.dart';
import 'package:appo/src/core/extension/build_context_extension.dart';
import 'package:appo/src/features/appointments/presentation/view_models/calculated_date_view_model.dart';
import 'package:appo/src/features/appointments/presentation/view_models/panel_manager.dart';
import 'package:appo/src/features/appointments/presentation/view_models/show_calender_view_model.dart';
import 'package:appo/src/features/appointments/presentation/widgets/period_display_card/time_unit_widget.dart';
import 'package:appo/src/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PeriodDisplayCard extends StatelessWidget {
  const PeriodDisplayCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaleTapAnimation(
      onTap: () => _handleReset(context: context),
      child: const _BuildUnitCard(),
    );
  }

  void _handleReset({required BuildContext context}) {
    final panelManager = context.read<PanelManager>();
    final calederManager = context.read<ShowCalenderViewModel>();
    final dateViewModel = context.read<CalculatedDateViewModel>();

    // reset the time adjuster in the panel manager
    panelManager.resetTime();

    // get the reset time adjuster
    final timeAdjuster = panelManager.timeAdjuster;

    // get the selected date from the calender manager
    final selectedDate = calederManager.selectedDate;

    // re calculate the date based on the selected date and the reset time adjuster
    dateViewModel.calculateDate(
      startDate: selectedDate,
      adjuster: timeAdjuster,
    );
  }
}

class _BuildUnitCard extends StatelessWidget {
  const _BuildUnitCard();

  @override
  Widget build(BuildContext context) {
    final ui = context.uiBuilder;

    return FractionallySizedBox(
      widthFactor: 0.8,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        decoration: ui.displayDecoration,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            TimeUnitWidget(unit: TimeUnit.days),
            TimeUnitWidget(unit: TimeUnit.months),
            TimeUnitWidget(unit: TimeUnit.years),
          ],
        ),
      ),
    );
  }
}
