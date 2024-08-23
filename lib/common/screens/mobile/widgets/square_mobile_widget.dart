import 'package:flutter/material.dart';

class SquareMobileWidget extends StatelessWidget {
  final Widget child;

  const SquareMobileWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    double width = (MediaQuery.of(context).size.width * 0.3) - 30;

    double half = MediaQuery.of(context).size.width * 0.5;

    return Align(
      alignment: Alignment.topLeft,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: SizedBox(
          // width: width * 2,
          width: half - 30,
          // height: width * 2,
          height: half - 30,
          child: child,
        ),
      ),
    );
  }
}
