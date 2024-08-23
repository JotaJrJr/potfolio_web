import 'dart:math';

import 'package:flutter/material.dart';

import '../models/calculator_function_cell.dart';
import '../models/calculator_operation_cell.dart';
import '../models/calculator_text_cell.dart';
import '../models/calculator_unique_function_cell.dart';

class CalculatorCells {
  static const Color _firstGrey = Color(0xFF615C5C);
  static const Color _secondGrey = Color(0xFF726F71);
  static const Color _orange = Color(0xFFFE9327);

  static final CalculatorFunctionCell clearButton = CalculatorFunctionCell(
    text: 'C',
    color: _firstGrey,
    onPressed: (viewModel) {
      viewModel.selectedValue = null;
      viewModel.showLastValue = false;
    },
  );

  static final CalculatorFunctionCell acButton = CalculatorFunctionCell(
    text: 'AC',
    color: _firstGrey,
    onPressed: (viewModel) => viewModel.clear(),
  );

  static final CalculatorUniqueFunctionCell changeSignButton = CalculatorUniqueFunctionCell(
    text: '+/-',
    color: _firstGrey,
    operation: (p0) {
      return (-p0).toString();
    },
  );

  static final CalculatorUniqueFunctionCell percentageButton = CalculatorUniqueFunctionCell(
    text: '%',
    color: _firstGrey,
    operation: (p0) {
      return (p0 / 100).toString();
    },
  );

  static final CalculatorOperationCell divisionButton = CalculatorOperationCell(
    text: '/',
    color: _orange,
    operation: (p0, p1) {
      return p0 / p1;
    },
  );

  static final CalculatorTextCell sevenButton = CalculatorTextCell(
    text: '7',
    color: _secondGrey,
  );

  static final CalculatorTextCell eightButton = CalculatorTextCell(
    text: '8',
    color: _secondGrey,
  );

  static final CalculatorTextCell nineButton = CalculatorTextCell(
    text: '9',
    color: _secondGrey,
  );

  static final CalculatorOperationCell multiplicationButton = CalculatorOperationCell(
    text: 'x',
    color: _orange,
    operation: (p0, p1) {
      return p0 * p1;
    },
  );

  static final CalculatorTextCell fourButton = CalculatorTextCell(
    text: '4',
    color: _secondGrey,
  );

  static final CalculatorTextCell fiveButton = CalculatorTextCell(
    text: '5',
    color: _secondGrey,
  );

  static final CalculatorTextCell sixButton = CalculatorTextCell(
    text: '6',
    color: _secondGrey,
  );

  static final CalculatorOperationCell subtractionButton = CalculatorOperationCell(
    text: '-',
    color: _orange,
    operation: (p0, p1) {
      return p0 - p1;
    },
  );

  static final CalculatorTextCell oneButton = CalculatorTextCell(
    text: '1',
    color: _secondGrey,
  );

  static final CalculatorTextCell twoButton = CalculatorTextCell(
    text: '2',
    color: _secondGrey,
  );

  static final CalculatorTextCell threeButton = CalculatorTextCell(
    text: '3',
    color: _secondGrey,
  );

  static final CalculatorOperationCell additionButton = CalculatorOperationCell(
    text: '+',
    color: _orange,
    operation: (p0, p1) {
      return p0 + p1;
    },
  );

  static final CalculatorTextCell zeroButton = CalculatorTextCell(
    text: '0',
    color: _secondGrey,
    size: 2,
  );

  static final CalculatorUniqueFunctionCell dotButton = CalculatorUniqueFunctionCell(
    text: '.',
    color: _secondGrey,
    operation: (p0) {
      if (p0.toString().contains('.')) {
        return p0.toString();
      }

      return '$p0.';
    },
  );

  static final CalculatorFunctionCell equalButton = CalculatorFunctionCell(
    text: '=',
    color: _orange,
    onPressed: (viewModel) => viewModel.execute(),
  );

  // Big Calculator

  // First Line
  static final CalculatorUniqueFunctionCell mrButton = CalculatorUniqueFunctionCell(
    text: 'MR',
    color: _firstGrey,
    operation: (p0) {
      return p0.toString();
    },
  );

  static final CalculatorUniqueFunctionCell mcButton = CalculatorUniqueFunctionCell(
    text: 'MC',
    color: _firstGrey,
    operation: (p0) {
      return '0';
    },
  );

  static final CalculatorUniqueFunctionCell mPlusButton = CalculatorUniqueFunctionCell(
    text: 'M+',
    color: _firstGrey,
    operation: (p0) {
      return p0.toString();
    },
  );

  static final CalculatorUniqueFunctionCell mMinusButton = CalculatorUniqueFunctionCell(
    text: 'M-',
    color: _firstGrey,
    operation: (p0) {
      return p0.toString();
    },
  );

  static final CalculatorUniqueFunctionCell openParenthesesButton = CalculatorUniqueFunctionCell(
    text: '(',
    color: _firstGrey,
    operation: (p0) {
      return p0.toString();
    },
  );

  static final CalculatorUniqueFunctionCell closeParenthesesButton = CalculatorUniqueFunctionCell(
    text: ')',
    color: _firstGrey,
    operation: (p0) {
      return p0.toString();
    },
  );

  // Second Line

  static final CalculatorUniqueFunctionCell secondButton = CalculatorUniqueFunctionCell(
    text: '2nd',
    color: _firstGrey,
    operation: (p0) {
      // return p0.toString();

      return "Vou fazer ainda, calma";
    },
  ); // TODO FALTA FAZER // PUTA QUE PARIU ALTERAR MUITA COISA

  static final CalculatorUniqueFunctionCell squareButton = CalculatorUniqueFunctionCell(
    text: 'x²',
    color: _firstGrey,
    operation: (p0) {
      return (p0 * p0).toString();
    },
  );

  static final CalculatorUniqueFunctionCell xToThePowerOfTwoButton = CalculatorUniqueFunctionCell(
    text: 'x^3',
    color: _firstGrey,
    operation: (p0) {
      return pow(p0, 3).toString();
    },
  );

  static final CalculatorOperationCell xToThePowerOfY = CalculatorOperationCell(
    text: 'x^y',
    color: _firstGrey,
    operation: (p0, p1) {
      return pow(p0, p1).toDouble();
    },
  );

  static final CalculatorUniqueFunctionCell eButtonToThePowerOfX = CalculatorUniqueFunctionCell(
    text: 'e^x',
    color: _firstGrey,
    operation: (p0) {
      return exp(p0).toString();
    },
  );

  static final CalculatorUniqueFunctionCell tenToThePowerOfX = CalculatorUniqueFunctionCell(
    text: '10^x',
    color: _firstGrey,
    operation: (p0) {
      return pow(10, p0).toString();
    },
  );

  // third line

  static final CalculatorUniqueFunctionCell oneOverXButton = CalculatorUniqueFunctionCell(
    text: '1/x',
    color: _firstGrey,
    operation: (p0) {
      return (1 / p0).toString();
    },
  );

  static final CalculatorUniqueFunctionCell squareRootButton = CalculatorUniqueFunctionCell(
    text: '√',
    color: _firstGrey,
    operation: (p0) {
      return sqrt(p0).toString();
    },
  );

  static final CalculatorUniqueFunctionCell threeSquareRootOfX = CalculatorUniqueFunctionCell(
    text: '3√x',
    color: _firstGrey,
    operation: (p0) {
      return pow(p0, 1 / 3).toString();
    },
  );

  static final CalculatorOperationCell ySquareRootOfX = CalculatorOperationCell(
    text: 'y√x',
    color: _firstGrey,
    operation: (p0, p1) {
      return pow(p1, 1 / p0).toDouble();
    },
  );

  static final CalculatorUniqueFunctionCell lnButton = CalculatorUniqueFunctionCell(
    text: 'ln',
    color: _firstGrey,
    operation: (p0) {
      return log(p0).toString();
    },
  );

  static final CalculatorUniqueFunctionCell logButton = CalculatorUniqueFunctionCell(
    text: 'log',
    color: _firstGrey,
    operation: (p0) {
      return (log(p0) / log(10)).toString();
    },
  );

  // Forth line

  static final CalculatorUniqueFunctionCell factorial = CalculatorUniqueFunctionCell(
    text: 'x!',
    color: _firstGrey,
    operation: (p0) {
      return factorialFunction(p0).toString();
    },
  );

  static final CalculatorUniqueFunctionCell sinButton = CalculatorUniqueFunctionCell(
    text: 'sin',
    color: _firstGrey,
    operation: (p0) {
      return sin(p0).toString();
    },
  );

  static final CalculatorUniqueFunctionCell cosButton = CalculatorUniqueFunctionCell(
    text: 'cos',
    color: _firstGrey,
    operation: (p0) {
      return sin(p0).toString();
    },
  );

  static final CalculatorUniqueFunctionCell tanButton = CalculatorUniqueFunctionCell(
    text: 'tan',
    color: _firstGrey,
    operation: (p0) {
      return tan(p0).toString();
    },
  );

  static final CalculatorUniqueFunctionCell eButton = CalculatorUniqueFunctionCell(
    text: 'e',
    color: _firstGrey,
    operation: (p0) {
      return "2.71828";
    },
  );

  static final CalculatorOperationCell enterExpoent = CalculatorOperationCell(
    text: 'EE',
    color: _firstGrey,
    operation: (p0, p1) {
      return p0 * (pow(10, p1));
    },
  );

  // Fifth line

  static final CalculatorUniqueFunctionCell radButton = CalculatorUniqueFunctionCell(
    text: 'rad',
    color: _firstGrey,
    operation: (p0) {
      return "Vou fazer ainda, calma";
    },
  ); // TODO FALTA FAZER

  static final CalculatorUniqueFunctionCell sinhButton = CalculatorUniqueFunctionCell(
    text: 'sinh',
    color: _firstGrey,
    operation: (p0) {
      return ((exp(p0) - exp(-p0)) / 2).toString();
    },
  );

  static final CalculatorUniqueFunctionCell coshButton = CalculatorUniqueFunctionCell(
    text: 'cosh',
    color: _firstGrey,
    operation: (p0) {
      return ((exp(p0) + exp(-p0)) / 2).toString();
    },
  );

  static final CalculatorUniqueFunctionCell tanhButton = CalculatorUniqueFunctionCell(
    text: 'tanh',
    color: _firstGrey,
    operation: (p0) {
      return ((exp(p0) - exp(-p0)) / (exp(p0) + exp(-p0))).toString();
    },
  );

  static final CalculatorUniqueFunctionCell piButton = CalculatorUniqueFunctionCell(
    text: 'π',
    color: _firstGrey,
    operation: (p0) {
      return pi.toString();
    },
  );

  static final CalculatorUniqueFunctionCell rand = CalculatorUniqueFunctionCell(
    text: 'Rand',
    color: _firstGrey,
    operation: (p0) {
      Random random = Random();

      return random.nextDouble().toString();
    },
  );

  static double factorialFunction(double p0) {
    if (p0 == 1 || p0 == 0) {
      return 1;
    }

    return p0 * factorialFunction(p0 - 1);
  }
}
