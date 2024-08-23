import 'package:flutter/material.dart';

import '../viewmodel/calculator_view_model.dart';
import '../../../shared/action_button_widget.dart';
import '../viewports/calculadora_large_view_port.dart';
import '../viewports/calculadora_small_view_port.dart';

class Calculator extends StatefulWidget {
  final ValueNotifier<bool> maximizado;
  final VoidCallback? onMinimize;
  final VoidCallback? onClose;

  const Calculator({
    super.key,
    required this.maximizado,
    this.onMinimize,
    this.onClose,
  });

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  late CalculatorViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = CalculatorViewModel();
    widget.maximizado.addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: AnimatedBuilder(
            animation: _viewModel,
            builder: (_, __) {
              return Container(
                width: widget.maximizado.value ? 600 : 200,
                decoration: const BoxDecoration(
                  color: Color(0xFF514C4C),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ActionRowButtons(
                      onClose: widget.onClose ?? () {},
                      onMinimize: widget.onMinimize ?? () {},
                      onMaximize: () {
                        _viewModel.changeSize(widget.maximizado);
                        setState(() {});
                      },
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 8,
                      ),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          _viewModel.displayText,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    AnimatedBuilder(
                      animation: _viewModel,
                      builder: (_, __) {
                        if (!widget.maximizado.value) {
                          return CalculadoraSmallPortView(viewModel: _viewModel);
                        } else {
                          return CalculadoraLargeViewPort(viewModel: _viewModel);
                        }
                      },
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }
}

class ActionRowButtons extends StatelessWidget {
  late Function? onClose;
  late Function? onMinimize;
  late Function? onMaximize;

  ActionRowButtons({super.key, this.onClose, this.onMinimize, this.onMaximize});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ActionButtonWidget(
            color: Colors.red,
            text: "+",
            angle: 0.785398,
            onPressed: onClose ?? () {},
          ),
          const SizedBox(width: 8),
          ActionButtonWidget(
            color: Colors.yellow,
            text: "-",
            onPressed: onMinimize ?? () {},
          ),
          const SizedBox(width: 8),
          ActionButtonWidget(
            color: Colors.green,
            text: "+",
            onPressed: onMaximize ?? () {},
          ),
        ],
      ),
    );
  }
}
