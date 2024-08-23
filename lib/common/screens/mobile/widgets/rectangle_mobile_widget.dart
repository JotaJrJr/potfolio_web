import 'package:flutter/material.dart';

class RectangleMobileWidget extends StatelessWidget {
  final Widget child;

  const RectangleMobileWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    double half = MediaQuery.of(context).size.width * 0.5;

    return Align(
      alignment: Alignment.topLeft,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: SizedBox(
          // width: (half * 2) - 30,
          width: double.infinity,
          // height: 40,
          child: child,
        ),
      ),
    );
  }
}
