import 'package:appo/src/core/constants/colors.dart';
import 'package:appo/src/core/enums/time_unit.dart';
import 'package:appo/src/core/utils/responsive.dart';
import 'package:appo/src/features/appointments/presentation/view_models/appointment_screen_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ButtonsPanel extends StatelessWidget {
  const ButtonsPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: DeltaUnit.values
          .map((timeUnit) => PanelButtonList(deltaUnit: timeUnit))
          .toList(),
    );
  }
}

class PanelButtonList extends StatelessWidget {
  final DeltaUnit deltaUnit;
  const PanelButtonList({super.key, required this.deltaUnit});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<AppointmentScreenVm>();

    return Column(
      children: deltaUnit.intervals.map((number) {
        final isLast = number.isNegative;

        return PanelButton(
          number: number,
          isLast: isLast,
          onPressed: () {
            // viewModel.updateValue(type: timeUnit.name, number: number);
            viewModel.adjustTimeUnit(deltaUnit, number);
          },
        );
      }).toList(),
    );
  }
}

class PanelButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final int number;
  final bool isLast;

  const PanelButton({
    super.key,
    required this.number,
    required this.isLast,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    Responsive.init(context: context);

    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: Responsive.wp(12),
          height: Responsive.wp(12),
          // padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: isLast ? AppColors.red : Colors.black,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey, width: 2.0),
            boxShadow: [
              BoxShadow(
                color: Color(0x16393535),
                offset: Offset(0, 6),
                blurRadius: 20,
              ),
            ],
          ),
          child: Center(
            child: Text(
              "${number.abs()}",
              style: TextStyle(fontSize: Responsive.sp(5), color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
