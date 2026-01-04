import 'package:appo/src/features/appointments/presentation/view_models/calculated_date_view_model.dart';
import 'package:appo/src/features/appointments/presentation/view_models/panel_manager.dart';
import 'package:appo/src/features/appointments/presentation/view_models/show_calender_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CalenderResetButtton extends StatelessWidget {
  const CalenderResetButtton({super.key});

  @override
  Widget build(BuildContext context) {
    final calenderViewModel = context.read<ShowCalenderViewModel>();
    final dateViewModel = context.read<CalculatedDateViewModel>();
    final panelManager = context.read<PanelManager>();

    return InkWell(
      onTap: () {
        calenderViewModel
            .resetStartDate; // reset the current month on the calender view
        dateViewModel.resetStartDate(); // reset the stsrt date
        panelManager.resetTime(); // reset the time adjuster
        dateViewModel.calculateDate(adjuster: panelManager.timeAdjuster);
        Navigator.pop(context);
      },
      child: ResetButtonCard(),
    );
  }
}

class ResetButtonCard extends StatelessWidget {
  const ResetButtonCard({super.key});

  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context).size.width;
    final fontSize = query < 600 ? 14.0 : 18.0;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.all(Radius.circular(18.0)),
      ),
      child: Center(
        child: Text(
          "Reset Date",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: fontSize,
          ),
        ),
      ),
    );
  }
}
