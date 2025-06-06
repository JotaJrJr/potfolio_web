import 'package:flutter/material.dart';

class MobileCalculatorButtonWidget extends StatefulWidget {
  const MobileCalculatorButtonWidget({super.key});

  @override
  State<MobileCalculatorButtonWidget> createState() => _MobileCalculatorButtonWidgetState();
}

class _MobileCalculatorButtonWidgetState extends State<MobileCalculatorButtonWidget> {
  @override
  Widget build(BuildContext context) {
    final double _width = MediaQuery.of(context).size.width * 0.11;
    return GestureDetector(
      onTap: () {},
      child: CircleAvatar(
        radius: _width,
        child: Text(
          "AC",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
