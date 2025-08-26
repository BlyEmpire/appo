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
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: TimeUnit.values
          .map((timeUnit) => PanelButtonList(timeUnit: timeUnit))
          .toList(),
    );
  }
}

class PanelButtonList extends StatelessWidget {
  final TimeUnit timeUnit;
  const PanelButtonList({super.key, required this.timeUnit});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<AppointmentScreenVm>();

    // timeUnit.name ==

    return Column(
      children: timeUnit.intervals.map((number) {
        final isLast = number.isNegative;

        return PanelButton(
          number: number,
          isLast: isLast,
          onPressed: () {
            viewModel.updateValue(type: timeUnit.name, number: number);
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

    return InkWell(
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
