import 'package:flutter/material.dart';

import '../constants/calculator_cell_views.dart';
import '../constants/calculator_cells.dart';
import '../models/calculator_cell.dart';
import '../models/calculator_cell_view.dart';
import '../viewmodel/calculator_view_model.dart';
import '../widgets/calculator_button_widget.dart';

class CalculadoraSmallPortView extends StatelessWidget {
  final CalculatorViewModel viewModel;

  const CalculadoraSmallPortView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: smallCalculator.map((row) {
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

  static List<List<CalculatorCellView>> smallCalculator = [
    [
      CalculatorCellViews.deleteButton,
      CalculatorCellView.staticButton(CalculatorCells.changeSignButton),
      CalculatorCellView.staticButton(CalculatorCells.percentageButton),
      CalculatorCellView.staticButton(CalculatorCells.divisionButton),
    ],
    [
      CalculatorCellView.staticButton(CalculatorCells.sevenButton),
      CalculatorCellView.staticButton(CalculatorCells.eightButton),
      CalculatorCellView.staticButton(CalculatorCells.nineButton),
      CalculatorCellView.staticButton(CalculatorCells.multiplicationButton),
    ],
    [
      CalculatorCellView.staticButton(CalculatorCells.fourButton),
      CalculatorCellView.staticButton(CalculatorCells.fiveButton),
      CalculatorCellView.staticButton(CalculatorCells.sixButton),
      CalculatorCellView.staticButton(CalculatorCells.subtractionButton),
    ],
    [
      CalculatorCellView.staticButton(CalculatorCells.oneButton),
      CalculatorCellView.staticButton(CalculatorCells.twoButton),
      CalculatorCellView.staticButton(CalculatorCells.threeButton),
      CalculatorCellView.staticButton(CalculatorCells.additionButton),
    ],
    [
      CalculatorCellView.staticButton(CalculatorCells.zeroButton, size: 2),
      CalculatorCellView.staticButton(CalculatorCells.dotButton),
      CalculatorCellView.staticButton(CalculatorCells.equalButton),
    ],
  ];
}
