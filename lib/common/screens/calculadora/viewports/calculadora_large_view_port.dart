import 'package:flutter/material.dart';

import '../constants/calculator_cell_views.dart';
import '../constants/calculator_cells.dart';
import '../models/calculator_cell.dart';
import '../models/calculator_cell_view.dart';
import '../viewmodel/calculator_view_model.dart';
import '../widgets/calculator_button_widget.dart';

class CalculadoraLargeViewPort extends StatelessWidget {
  final CalculatorViewModel viewModel;

  const CalculadoraLargeViewPort({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: bigCalculator.map((row) {
        return Row(
          children: row.map((cell) {
            CalculatorCell cellResult = cell.onRender(viewModel);
            return Expanded(
              flex: cell.size,
              child: CalculatorButtonWidget(
                text: cellResult.text,
                color: cellResult.color,
                onPressed: () {
                  viewModel.executeCell(cellResult);
                },
              ),
            );
          }).toList(),
        );
      }).toList(),
    );
  }

  static List<List<CalculatorCellView>> bigCalculator = [
    [
      CalculatorCellView.staticButton(CalculatorCells.openParenthesesButton),
      CalculatorCellView.staticButton(CalculatorCells.closeParenthesesButton),
      CalculatorCellView.staticButton(CalculatorCells.mcButton),
      CalculatorCellView.staticButton(CalculatorCells.mPlusButton),
      CalculatorCellView.staticButton(CalculatorCells.mMinusButton),
      CalculatorCellView.staticButton(CalculatorCells.mrButton),
      CalculatorCellViews.deleteButton,
      CalculatorCellView.staticButton(CalculatorCells.changeSignButton),
      CalculatorCellView.staticButton(CalculatorCells.percentageButton),
      CalculatorCellView.staticButton(CalculatorCells.divisionButton),
    ],
    [
      CalculatorCellView.staticButton(CalculatorCells.secondButton),
      CalculatorCellView.staticButton(CalculatorCells.squareButton),
      CalculatorCellView.staticButton(CalculatorCells.xToThePowerOfTwoButton),
      CalculatorCellView.staticButton(CalculatorCells.xToThePowerOfY),
      CalculatorCellView.staticButton(CalculatorCells.eButtonToThePowerOfX),
      CalculatorCellView.staticButton(CalculatorCells.tenToThePowerOfX),
      CalculatorCellView.staticButton(CalculatorCells.sevenButton),
      CalculatorCellView.staticButton(CalculatorCells.eightButton),
      CalculatorCellView.staticButton(CalculatorCells.nineButton),
      CalculatorCellView.staticButton(CalculatorCells.multiplicationButton),
    ],
    [
      CalculatorCellView.staticButton(CalculatorCells.oneOverXButton),
      CalculatorCellView.staticButton(CalculatorCells.squareRootButton),
      CalculatorCellView.staticButton(CalculatorCells.threeSquareRootOfX),
      CalculatorCellView.staticButton(CalculatorCells.ySquareRootOfX),
      CalculatorCellView.staticButton(CalculatorCells.lnButton),
      CalculatorCellView.staticButton(CalculatorCells.logButton),
      CalculatorCellView.staticButton(CalculatorCells.fourButton),
      CalculatorCellView.staticButton(CalculatorCells.fiveButton),
      CalculatorCellView.staticButton(CalculatorCells.sixButton),
      CalculatorCellView.staticButton(CalculatorCells.subtractionButton),
    ],
    [
      CalculatorCellView.staticButton(CalculatorCells.factorial),
      CalculatorCellView.staticButton(CalculatorCells.sinButton),
      CalculatorCellView.staticButton(CalculatorCells.cosButton),
      CalculatorCellView.staticButton(CalculatorCells.tanButton),
      CalculatorCellView.staticButton(CalculatorCells.eButton),
      CalculatorCellView.staticButton(CalculatorCells.enterExpoent),
      CalculatorCellView.staticButton(CalculatorCells.oneButton),
      CalculatorCellView.staticButton(CalculatorCells.twoButton),
      CalculatorCellView.staticButton(CalculatorCells.threeButton),
      CalculatorCellView.staticButton(CalculatorCells.additionButton),
    ],
    [
      CalculatorCellView.staticButton(CalculatorCells.radButton),
      CalculatorCellView.staticButton(CalculatorCells.sinhButton),
      CalculatorCellView.staticButton(CalculatorCells.coshButton),
      CalculatorCellView.staticButton(CalculatorCells.tanhButton),
      CalculatorCellView.staticButton(CalculatorCells.piButton),
      CalculatorCellView.staticButton(CalculatorCells.rand),
      CalculatorCellView.staticButton(CalculatorCells.zeroButton, size: 2),
      CalculatorCellView.staticButton(CalculatorCells.dotButton),
      CalculatorCellView.staticButton(CalculatorCells.equalButton),
    ],
  ];
}
