import 'package:flutter/material.dart';

class ScaleTapAnimation extends StatefulWidget {
  const ScaleTapAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(microseconds: 100),
    this.scaleFactor = 1.1,
    this.onTap,
  });

  final Widget child;
  final VoidCallback? onTap;
  final double scaleFactor;
  final Duration duration;

  @override
  State<ScaleTapAnimation> createState() => _ScaleTapAnimationState();
}

class _ScaleTapAnimationState extends State<ScaleTapAnimation> {
  double _scale = 1.0;

  void _tapDown(TapDownDetails details) {
    setState(() {
      _scale = widget.scaleFactor;
    });
  }

  void _tapUp(TapUpDetails details) {
    setState(() {
      _scale = 1.0;
      widget.onTap?.call();
    });
  }

  void _tapCancel() {
    setState(() {
      _scale = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _tapDown,
      onTapUp: _tapUp,
      onTapCancel: _tapCancel,
      child: AnimatedScale(
        scale: _scale,
        duration: widget.duration,
        curve: Curves.easeIn,
        child: widget.child,
      ),
    );
  }
}
