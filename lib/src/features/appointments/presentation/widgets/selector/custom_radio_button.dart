import 'package:appo/src/core/enums/time_unit.dart';
import 'package:appo/src/core/extension/build_context_extension.dart';
import 'package:appo/src/features/appointments/presentation/view_models/calculated_date_view_model.dart';
import 'package:appo/src/features/appointments/presentation/view_models/panel_manager.dart';
import 'package:appo/src/features/appointments/presentation/view_models/selector_view_model.dart';
import 'package:appo/src/shared/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// A CustomRadioButton is used to set the operation on the start date, wheather
/// addition or subtraction
class CustomRadioButton extends StatelessWidget {
  final DateOperation dateOp;

  const CustomRadioButton({super.key, required this.dateOp});

  IconData iconChooser({required DateOperation operation}) {
    final isSelected = operation == DateOperation.add;
    return isSelected
        ? Icons.arrow_forward_ios_rounded
        : Icons.arrow_back_ios_new_rounded;
  }

  @override
  Widget build(BuildContext context) {
    final panelManager = context.read<PanelManager>();
    final selectorManager = context.read<SelectorViewModel>();
    final dateManager = context.read<CalculatedDateViewModel>();

    bool isSelected = context.select<SelectorViewModel, bool>(
      (e) => e.isSelected(operation: dateOp),
    );

    return GestureDetector(
      onTap: () => _handleButtonPressed(
        dateManager: dateManager,
        panelManager: panelManager,
        selectorManager: selectorManager,
      ),
      child: _BuildToggleButton(
        isSelected: isSelected,
        icon: iconChooser(operation: dateOp),
      ),
    );
  }

  void _handleButtonPressed({
    required SelectorViewModel selectorManager,
    required CalculatedDateViewModel dateManager,
    required PanelManager panelManager,
  }) {
    // set operation
    selectorManager.setOperation(operation: dateOp);

    // get operation
    final operation = selectorManager.currentOperation;
    final adjuster = panelManager.timeAdjuster;

    // calculate the appointment date
    dateManager.calculateDate(adjuster: adjuster, operation: operation);
  }
}

class _BuildToggleButton extends StatelessWidget {
  const _BuildToggleButton({required this.isSelected, required this.icon});

  final bool isSelected;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final uiBuilder = context.uiBuilder;
    final selectionColor = isSelected
        ? AppColors.textPrimary
        : AppColors.buttonGrey;

    return CircleAvatar(
      radius: uiBuilder.circleAvatarRadius,
      backgroundColor: AppColors.buttonGrey,
      child: Container(
        margin: EdgeInsets.all(uiBuilder.toggleMargin),
        decoration: BoxDecoration(
          color: selectionColor,
          shape: BoxShape.circle,
        ),
        child: isSelected
            ? Center(child: Icon(icon, size: uiBuilder.toggleIconSize))
            : null,
      ),
    );
  }
}
