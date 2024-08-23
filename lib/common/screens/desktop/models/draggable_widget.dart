import 'package:flutter/widgets.dart';

class DraggableWidget {
  final Widget widget;
  Offset position;
  bool isVisible;
  String id;

  DraggableWidget({
    required this.widget,
    required this.position,
    required this.id,
    this.isVisible = false,
  });
}
