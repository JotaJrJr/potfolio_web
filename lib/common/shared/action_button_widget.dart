import 'package:flutter/material.dart';

class ActionButtonWidget extends StatelessWidget {
  final Color color;

  final String text;
  final Function onPressed;
  double? angle;

  ActionButtonWidget({super.key, required this.color, required this.text, required this.onPressed, this.angle = 0});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationZ(angle!),
          child: GestureDetector(
            onTap: () => onPressed(),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black,
              ),
            ),
          ),
        )
      ],
    );
  }
}
