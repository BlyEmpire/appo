import 'package:appo/src/core/constants/colors.dart';
import 'package:appo/src/core/utils/responsive.dart';
import 'package:flutter/material.dart';

class PanelButton extends StatelessWidget {
  static const double _buttonSize = 12.0; // percentage of screen width
  static const double _fontSize = 5.0; // responsive scale
  static const double _padding = 8.0;
  static const double _borderWidth = 2.0;

  static const Color _shadowColor = Color(0x16393535);
  static const Offset _shadowOffset = Offset(0, 6);
  static const double _shadowBlurRadius = 20.0;

  final VoidCallback onPressed;
  final int value;
  final bool isResetButton;

  const PanelButton({
    super.key,
    required this.value,
    required this.isResetButton,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    Responsive.init(context: context);

    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(_padding),
        child: Container(
          width: Responsive.wp(_buttonSize),
          height: Responsive.wp(_buttonSize),
          decoration: BoxDecoration(
            color: isResetButton ? AppColors.red : Colors.black,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey, width: _borderWidth),
            boxShadow: const [
              BoxShadow(
                color: _shadowColor,
                offset: _shadowOffset,
                blurRadius: _shadowBlurRadius,
              ),
            ],
          ),
          child: Center(
            child: Text(
              _getButtonText(),
              style: TextStyle(
                fontSize: Responsive.sp(_fontSize),
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _getButtonText() {
    if (isResetButton) {
      return 'All'; // or 'Reset' depending on your intended behavior
    }
    return value.abs().toString();
  }
}
