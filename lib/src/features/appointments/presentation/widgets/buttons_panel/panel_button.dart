import 'package:appo/src/core/extension/build_context_extension.dart';
import 'package:appo/src/shared/animations/scale_tap_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PanelButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final int number;

  const PanelButton({super.key, required this.number, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final uiBuilder = context.uiBuilder;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ScaleTapAnimation(
        onTap: () => _onPressed(),
        child: Container(
          width: uiBuilder.roundButtonSize,
          height: uiBuilder.roundButtonSize,
          decoration: uiBuilder.buttonDecoration(number: number),
          child: Center(
            child: Text(
              number.abs().toString(),
              style: uiBuilder.roundButtonTextStyle,
            ),
          ),
        ),
      ),
    );
  }

  void _onPressed() {
    HapticFeedback.lightImpact();
    onPressed?.call();
  }
}
