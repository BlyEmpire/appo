import 'package:appo/src/shared/shared.dart';
import 'package:flutter/widgets.dart';

class UI extends InheritedWidget {
  final UIBuilder builder;

  const UI({super.key, required super.child, required this.builder});

  static UIBuilder of(BuildContext context) {
    final ui = context.dependOnInheritedWidgetOfExactType<UI>();
    return ui!.builder;
  }

  @override
  bool updateShouldNotify(covariant UI oldWidget) {
    return oldWidget.builder.constraints != builder.constraints;
  }
}
