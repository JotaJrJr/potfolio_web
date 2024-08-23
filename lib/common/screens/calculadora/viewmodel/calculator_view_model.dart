import 'package:flutter/material.dart';

import '../models/calculator_cell.dart';
import '../models/calculator_function_cell.dart';
import '../models/calculator_operation_cell.dart';
import '../models/calculator_text_cell.dart';
import '../models/calculator_unique_function_cell.dart';

class CalculatorViewModel extends ChangeNotifier {
  List<String> historic = [];
  String? selectedValue;
  late double Function(double, double)? selectedOperation = null;

  bool showLastValue = false;
  String get lastValue => historic.lastOrNull ?? '0';
  String get displayText => selectedValue ?? (showLastValue ? lastValue : '0');

  bool isRadians = true;

  Offset assistiveTouchPosition = const Offset(0, 0);

  bool assistiveTouchExpanded = true;

  void assistiveTouchToggleExpanded() {
    assistiveTouchExpanded = !assistiveTouchExpanded;
    notifyListeners();
  }

  void toggleAngleMode() {
    isRadians = !isRadians;
    notifyListeners();
  }

  void changeOperation(double Function(double, double)? operation) {
    if (selectedValue != null && selectedOperation != null) {
      execute();
    }

    selectedOperation = operation;
    historic.add(selectedValue!);
    selectedValue = null;
  }

  void clickTextCell(String text) {
    if (selectedValue == null) {
      selectedValue = text;
    } else {
      selectedValue = selectedValue! + text;
    }
  }

  void executeCell(CalculatorCell cell) {
    showLastValue = false;

    if (cell is CalculatorTextCell) {
      clickTextCell(cell.text);
    }
    if (cell is CalculatorOperationCell) {
      changeOperation(cell.operation);
    }
    if (cell is CalculatorFunctionCell) {
      cell.onPressed(this);
    }
    if (cell is CalculatorUniqueFunctionCell) {
      selectedValue = cell.operation(double.parse(selectedValue ?? "0"));
    }
    notifyListeners();
  }

  void execute() {
    showLastValue = true;

    double result = selectedOperation!(double.parse(lastValue), double.parse(selectedValue!));
    historic.add(result.toString());
    selectedValue = null;
    selectedOperation = null;

    notifyListeners();
  }

  void clear() {
    selectedValue = null;
    historic.clear();
    notifyListeners();
  }

  void changeSize(ValueNotifier<bool> value) {
    value.value = !value.value;
    notifyListeners();
  }
}
