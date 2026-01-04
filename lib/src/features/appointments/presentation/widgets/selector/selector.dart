import 'package:appo/src/core/extension/build_context_extension.dart';
import 'package:appo/src/features/appointments/presentation/widgets/selector/custom_radio_button.dart';
import 'package:appo/src/core/enums/time_unit.dart';
import 'package:appo/src/features/appointments/presentation/widgets/selector/start_date_display.dart';
import 'package:flutter/material.dart';

/// A panel widget that lets the user pick a start date and choose whether to
/// add or subtract time from it.
///
/// It combines:
/// - [StartDateDisplay] to show and update the current date.
/// - [CustomRadioButton] widgets to toggle between addition and subtraction.
///
/// Use: It is used in the appointment screen to choose the operation relative
/// to the selected date.
class SelectorPanel extends StatelessWidget {
  const SelectorPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final uiBuilder = context.uiBuilder;
    return Container(
      padding: EdgeInsets.symmetric(vertical: uiBuilder.verticalWidgetSpacing),
      width: double.infinity,
      color: Colors.black,
      child: const FractionallySizedBox(
        widthFactor: 0.6,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomRadioButton(dateOp: DateOperation.subtract),
            Expanded(child: StartDateDisplay()),
            CustomRadioButton(dateOp: DateOperation.add),
          ],
        ),
      ),
    );
  }
}
