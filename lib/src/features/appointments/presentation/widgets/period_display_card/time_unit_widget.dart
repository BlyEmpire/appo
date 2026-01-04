import 'package:appo/src/core/enums/time_unit.dart';
import 'package:appo/src/core/extension/build_context_extension.dart';
import 'package:appo/src/features/appointments/presentation/view_models/panel_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TimeUnitWidget extends StatelessWidget {
  final TimeUnit unit;

  const TimeUnitWidget({super.key, required this.unit});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 2.0,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _BuildUnitName(unit: unit),
        _BuildUnitValue(unit: unit),
      ],
    );
  }
}

class _BuildUnitValue extends StatelessWidget {
  const _BuildUnitValue({required this.unit});

  final TimeUnit unit;

  @override
  Widget build(BuildContext context) {
    final ui = context.uiBuilder;
    final unitValue = context.select<PanelManager, String>(
      (vm) => vm.timeAdjuster.getValueFromUnit(unit: unit),
    );
    return Text(unitValue, style: ui.displayStyle());
  }
}

class _BuildUnitName extends StatelessWidget {
  const _BuildUnitName({required this.unit});
  final TimeUnit unit;

  @override
  Widget build(BuildContext context) {
    final ui = context.uiBuilder;
    return Text(unit.name, style: ui.displayStyle(isBold: false));
  }
}
