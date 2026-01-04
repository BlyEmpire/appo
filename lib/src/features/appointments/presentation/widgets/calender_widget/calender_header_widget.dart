import 'package:appo/src/core/extension/date_time_extension.dart';
import 'package:appo/src/features/appointments/presentation/view_models/show_calender_view_model.dart';
import 'package:appo/src/features/appointments/presentation/widgets/calender_widget/month_year_selector_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CalenderHeader extends StatelessWidget {
  const CalenderHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _BuildRightCalenderButtons(),
        _BuildMonthYearDisplay(),
        _BuildLeftCalenderButtons(),
      ],
    );
  }
}

class _BuildMonthYearDisplay extends StatelessWidget {
  const _BuildMonthYearDisplay();

  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context).size.width;
    final fontSize = query < 600 ? 14.0 : 18.0;

    return Expanded(
      child: Center(
        child: Selector<ShowCalenderViewModel, String>(
          builder: (_, monthYear, __) {
            return Text(
              monthYear,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize),
            );
          },
          selector: (_, vm) =>
              "${vm.currentMonth.monthName} ${vm.currentMonth.year}",
        ),
      ),
    );
  }
}

class _BuildLeftCalenderButtons extends StatelessWidget {
  const _BuildLeftCalenderButtons();

  @override
  Widget build(BuildContext context) {
    final calenderViewModel = context.read<ShowCalenderViewModel>();

    return Row(
      spacing: 4.0,
      children: [
        MonthYearSelectionButton(
          icon: Icons.chevron_right,
          onPressed: () => calenderViewModel.proceedToNextMonth(),
        ),
        MonthYearSelectionButton(
          icon: Icons.keyboard_double_arrow_right_outlined,
          onPressed: () => calenderViewModel.proceedToNextYear(),
        ),
      ],
    );
  }
}

class _BuildRightCalenderButtons extends StatelessWidget {
  const _BuildRightCalenderButtons();

  @override
  Widget build(BuildContext context) {
    final calenderViewModel = context.read<ShowCalenderViewModel>();

    return Row(
      spacing: 4.0,
      children: [
        MonthYearSelectionButton(
          icon: Icons.keyboard_double_arrow_left_outlined,
          onPressed: () => calenderViewModel.proceedToPreviousYear(),
        ),
        MonthYearSelectionButton(
          icon: Icons.chevron_left,
          onPressed: () => calenderViewModel.proceedToPreviosMonth(),
        ),
      ],
    );
  }
}
