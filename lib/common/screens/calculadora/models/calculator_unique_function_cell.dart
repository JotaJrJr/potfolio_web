import 'package:flutter/material.dart';

import 'calculator_cell.dart';

class CalculatorUniqueFunctionCell extends CalculatorCell {
  final String? Function(double) operation;
  CalculatorUniqueFunctionCell({required String text, required Color color, required this.operation}) : super(text: text, color: color);
}
