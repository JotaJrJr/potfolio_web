import 'package:flutter/material.dart';

class MobileAppWidget extends StatefulWidget {
  final String name;
  final String assetName;
  final Function onPressed;
  bool hasName;

  MobileAppWidget({super.key, required this.name, required this.assetName, required this.onPressed, this.hasName = true});

  @override
  State<MobileAppWidget> createState() => _MobileAppWidgetState();
}

class _MobileAppWidgetState extends State<MobileAppWidget> {
  @override
  Widget build(BuildContext context) {
    double width = (MediaQuery.of(context).size.width * 0.30) - 30;

    return Column(
      children: [
        SizedBox(
          width: width,
          height: width,
          child: GestureDetector(
            onTap: () => widget.onPressed(),
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage(widget.assetName),
                  fit: BoxFit.cover,
                )),
              ),
            ),
          ),
        ),
        widget.hasName
            ? Text(
                widget.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              )
            : Container(),
      ],
    );
  }
}
