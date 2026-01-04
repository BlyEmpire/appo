import 'package:flutter/material.dart';

class CalanderSelectionButton extends StatelessWidget {
  const CalanderSelectionButton({
    super.key,
    required this.name,
    required this.onPressed,
    this.isDark = false,
  });

  final String name;
  final VoidCallback? onPressed;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    Color containerColor = isDark ? Colors.black : Colors.white;
    Color colorText = isDark ? Colors.white : Colors.black;

    return Material(
      child: InkWell(
        onTap: onPressed,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 8.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(24.0),
            color: containerColor,
          ),
          child: Center(
            child: Text(name, style: TextStyle(color: colorText)),
          ),
        ),
      ),
    );
  }
}
