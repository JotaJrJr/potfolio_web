import 'package:flutter/material.dart';
import 'calculator_cell.dart';

class CalculatorOperationCell extends CalculatorCell {
  final double Function(double, double) operation;
  CalculatorOperationCell({required String text, required Color color, required this.operation}) : super(text: text, color: color);
}
