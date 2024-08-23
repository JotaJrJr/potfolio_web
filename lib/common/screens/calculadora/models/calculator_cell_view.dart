import '../viewmodel/calculator_view_model.dart';
import 'calculator_cell.dart';

class CalculatorCellView {
  final CalculatorCell Function(CalculatorViewModel) onRender;
  final int size;

  CalculatorCellView({required this.onRender, this.size = 1});

  static CalculatorCellView staticButton(CalculatorCell cell, {int size = 1}) {
    return CalculatorCellView(size: size, onRender: (viewModel) => cell);
  }
}
