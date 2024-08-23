// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class LayoutBuilderWidget extends StatelessWidget {
  final Widget Function(BuildContext context, BoxConstraints constraints, ValueNotifier<bool> maximizado) builder;
  final ValueNotifier<bool> isMaximizado;
  // context, constraints, maximizado

  const LayoutBuilderWidget({
    Key? key,
    required this.builder,
    required this.isMaximizado,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: isMaximizado,
        builder: (_, __) {
          return LayoutBuilder(builder: (context, constraints) {
            return builder(context, constraints, isMaximizado);
          });
        });
  }
}
