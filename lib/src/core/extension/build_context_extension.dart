import 'package:appo/src/shared/shared.dart';
import 'package:appo/src/shared/ui_builder/ui_builder_inherited.dart';
import 'package:flutter/material.dart';

extension UIBuildContext on BuildContext {
  UIBuilder get uiBuilder {
    return UI.of(this);
  }
}
