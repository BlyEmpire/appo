import 'package:appo/src/core/enums/time_unit.dart';
import 'package:appo/src/core/utils/responsive.dart';
import 'package:appo/src/features/appointments/presentation/view_models/appointment_screen_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PeriodDisplayCard extends StatelessWidget {
  const PeriodDisplayCard({super.key});

  // Design constants
  static const double _cardBorderRadius = 8.0;
  static const double _widgetPadding = 8.0;
  static const double _shadowBlurRadius = 26.0;
  static const Offset _shadowOffset = Offset(0, 20);
  static const Color _shadowColor = Color(0x16363535); // 8% opacity black

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<AppointmentScreenVm>();

    return InkWell(
      onTap: viewModel.reset,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(_cardBorderRadius),
          boxShadow: [
            BoxShadow(
              color: _shadowColor,
              blurRadius: _shadowBlurRadius,
              offset: _shadowOffset,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _TimeUnitWidget(unit: DeltaUnit.days, value: viewModel.days),
            _TimeUnitWidget(unit: DeltaUnit.months, value: viewModel.months),
            _TimeUnitWidget(unit: DeltaUnit.years, value: viewModel.years),
          ],
        ),
      ),
    );
  }
}

class _TimeUnitWidget extends StatelessWidget {
  final DeltaUnit unit;
  final int value;

  const _TimeUnitWidget({required this.unit, required this.value});

  // Font size constants
  static const double _unitLabelFontSize = 3.0;
  static const double _valueFontSize = 5.0;

  @override
  Widget build(BuildContext context) {
    Responsive.init(context: context);

    return Padding(
      padding: const EdgeInsets.all(PeriodDisplayCard._widgetPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            _getUnitDisplayName(unit),
            style: TextStyle(fontSize: Responsive.sp(_unitLabelFontSize)),
          ),
          Text(
            value.toString(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: Responsive.sp(_valueFontSize),
            ),
          ),
        ],
      ),
    );
  }

  String _getUnitDisplayName(DeltaUnit unit) {
    switch (unit) {
      case DeltaUnit.days:
        return 'Days';
      case DeltaUnit.months:
        return 'Months';
      case DeltaUnit.years:
        return 'Years';
    }
  }
}
