import 'package:flutter/material.dart';

class CalculatorButtonWidget extends StatefulWidget {
  final String text;
  final Color color;
  final Function onPressed;
  BorderRadius? borderRadius;

  CalculatorButtonWidget({super.key, required this.text, required this.color, required this.onPressed, this.borderRadius});

  @override
  State<CalculatorButtonWidget> createState() => _CalculatorButtonWidgetState();
}

class _CalculatorButtonWidgetState extends State<CalculatorButtonWidget> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          isPressed = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          isPressed = false;
        });
      },
      onTapCancel: () {
        setState(() {
          isPressed = false;
        });
      },
      onTap: () => widget.onPressed(),
      child: Container(
        margin: EdgeInsets.zero,
        decoration: BoxDecoration(
          color: isPressed ? widget.color.withOpacity(0.5) : widget.color,
          border: Border.all(
            width: isPressed ? 1 : 0.1,
            color: Colors.black,
          ),
          borderRadius: widget.borderRadius,
        ),
        height: 50,
        child: Center(
          child: Text(
            widget.text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
