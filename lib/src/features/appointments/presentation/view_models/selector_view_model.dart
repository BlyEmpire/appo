import 'package:appo/src/core/enums/time_unit.dart';
import 'package:flutter/material.dart';

class SelectorViewModel extends ChangeNotifier {
  DateOperation _currentOperation = DateOperation.add;
  DateOperation get currentOperation => _currentOperation;

  bool isSelected({required DateOperation operation}) {
    return operation == _currentOperation;
  }

  void setOperation({required DateOperation operation}) {
    if (_currentOperation == operation) return;
    _currentOperation = operation;
    notifyListeners();
  }
}
