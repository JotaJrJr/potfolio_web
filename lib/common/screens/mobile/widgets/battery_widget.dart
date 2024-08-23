import 'package:flutter/material.dart';

class BatteryWidget extends StatelessWidget {
  const BatteryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        Transform.rotate(
          angle: 3.14 / 2,
          child: const Icon(Icons.battery_6_bar_outlined, color: Colors.white, size: 35),
        ),
        const Positioned(
          top: 9,
          right: 13,
          child: Text(
            "80",
            style: TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
