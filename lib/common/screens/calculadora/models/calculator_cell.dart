import 'package:flutter/material.dart';

abstract class CalculatorCell {
  final String text;
  final Color color;

  CalculatorCell({required this.text, required this.color});
}
