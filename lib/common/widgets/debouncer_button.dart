import 'package:flutter/material.dart';

import '../utils/debouncer.dart';

class DebouncerButton extends StatefulWidget {
  final Widget child;
  final Duration debounceDuration;

  const DebouncerButton({Key? key, required this.child, required this.debounceDuration}) : super(key: key);

  @override
  _DebouncerButtonState createState() => _DebouncerButtonState();
}

class _DebouncerButtonState extends State<DebouncerButton> {
  late final Debouncer _debouncer;

  @override
  void initState() {
    super.initState();
    _debouncer = Debouncer(delay: widget.debounceDuration);
    overrideAction();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  overrideAction() {
    if (widget.child is TextField) {
      return TextField(
        onChanged: (value) {},
      );
    }
    // if(widget.child is TextField){
    //     VoidCallback(String text) wrote = (text) => {
    //         _debouncer.run(widget.child.onTextChanged.call())
    //     }
    // widget.child.onTextChanged = wrote;
    // }
    // if(widget.child is GestureDetector) {
    //      VoidCallback() clicked = () => {
    //         _debouncer.run(widget.child.onTap.call())
    //     }
    //     widget.child.onTap = clicked;
    // }
  }
}
