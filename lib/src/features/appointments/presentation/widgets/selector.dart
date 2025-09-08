import 'package:appo/src/core/constants/colors.dart';
import 'package:appo/src/core/utils/responsive.dart';
import 'package:appo/src/features/appointments/presentation/view_models/appointment_screen_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectorPanel extends StatelessWidget {
  const SelectorPanel({super.key});

  @override
  Widget build(BuildContext context) {
    // view model
    final vm = context.watch<AppointmentScreenVm>();

    return Container(
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CustomRadioButton(
            dateOp: DateOp.subtract,
            onPressed: () => vm.setOperation(DateOp.subtract),
          ),
          TodayDisplay(),
          CustomRadioButton(
            dateOp: DateOp.add,
            onPressed: () => vm.setOperation(DateOp.add),
          ),
        ],
      ),
    );
  }
}

class TodayDisplay extends StatelessWidget {
  const TodayDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    Responsive.init(context: context);
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Today's Date",
              style: TextStyle(color: Colors.white, fontSize: Responsive.sp(3)),
            ),
            Text(
              "12 July 2025",
              style: TextStyle(color: Colors.white, fontSize: Responsive.sp(4)),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomRadioButton extends StatelessWidget {
  final VoidCallback onPressed;
  final DateOp dateOp;

  const CustomRadioButton({
    super.key,
    required this.onPressed,
    required this.dateOp,
  });

  @override
  Widget build(BuildContext context) {
    Responsive.init(context: context);
    final vm = context.watch<AppointmentScreenVm>();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          width: 30.0,
          height: 30.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.gray,
            // border: BoxBorder.all(color: AppColors.gray, width: 5.0),
          ),
          child: Container(
            margin: EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: dateOp == vm.operation ? Colors.white : AppColors.gray,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: dateOp == vm.operation ? Colors.white : AppColors.gray,
                  blurRadius: 3.0,
                  spreadRadius: 1.0,
                  offset: Offset(0, 1),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
