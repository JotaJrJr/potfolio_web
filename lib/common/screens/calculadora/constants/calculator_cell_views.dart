import '../models/calculator_cell_view.dart';
import 'calculator_cells.dart';

class CalculatorCellViews {
  static CalculatorCellView deleteButton = CalculatorCellView(
    onRender: (viewModel) {
      if (viewModel.selectedValue != null || viewModel.showLastValue == true) {
        return CalculatorCells.clearButton;
      } else {
        return CalculatorCells.acButton;
      }
    },
  );
}
