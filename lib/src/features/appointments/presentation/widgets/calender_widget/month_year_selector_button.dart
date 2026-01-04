import 'package:flutter/material.dart';

class MonthYearSelectionButton extends StatelessWidget {
  const MonthYearSelectionButton({
    super.key,
    required this.onPressed,
    required this.icon,
  });

  final VoidCallback onPressed;
  final IconData icon;

  static const double buttonSize = 40.0;

  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context).size.width;
    final buttonDimension = query < 600 ? 40.0 : 50.0;
    final iconSize = query < 600 ? 16.0 : 20.0;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: buttonDimension,
        width: buttonDimension,
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border.all(color: Colors.black, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        child: Icon(icon, size: iconSize, color: Colors.white),
      ),
    );
  }
}
