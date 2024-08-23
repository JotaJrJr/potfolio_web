import 'dart:ui';

import 'package:flutter/material.dart';

import 'common/screens/calculadora/view/calculator.dart';
import 'common/screens/contacts/view/contact_page.dart';
import 'common/screens/desktop/models/draggable_widget.dart';

class TesteDragIcons extends StatefulWidget {
  const TesteDragIcons({super.key});

  @override
  State<TesteDragIcons> createState() => _TesteDragIconsState();
}

class _TesteDragIconsState extends State<TesteDragIcons> {
  late TesteDragIconsViewModel _viewModel;

  @override
  initState() {
    super.initState();
    _viewModel = TesteDragIconsViewModel();
  }

  List<DraggableWidget> widgets = [
    DraggableWidget(
      id: 'calculator',
      widget: Calculator(
        maximizado: ValueNotifier<bool>(false),
      ),
      position: const Offset(100, 100),
    ),
    DraggableWidget(
      id: 'contact',
      widget: const ContactPage(),
      position: const Offset(100, 100),
    ),
  ];

  Offset position = const Offset(100, 100);

  // Calculator currentWidget = const Calculator();

  ContactPage currentWidget = const ContactPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: TesteDragIconsViewModel(),
        builder: (_, __) {
          return Stack(
            // children: [
            //   for (int i = 0; i < _viewModel.widgets.length; i++)
            //     if (_viewModel.widgets[i].isVisible)
            //       Positioned(
            //         left: _viewModel.widgets[i].position.dx,
            //         top: _viewModel.widgets[i].position.dy,
            //         child: GestureDetector(
            //           onLongPress: () {
            //             _viewModel.bringToFront(i);
            //           },
            //           child: Draggable(
            //             data: _viewModel.widgets[i].position,
            //             feedback: Material(
            //               child: _viewModel.widgets[i].widget,
            //             ),
            //             childWhenDragging: Container(),
            //             child: _viewModel.widgets[i].widget,
            //             onDragEnd: (details) {
            //               setState(
            //                 () {
            //                   _viewModel.widgets[i].position = details.offset;
            //                 },
            //               );
            //             },
            //           ),
            //         ),
            //       ),
            //   Column(
            //     children: [
            //       const Spacer(),
            //       Align(
            //         child: ClipRRect(
            //           borderRadius: const BorderRadius.all(Radius.circular(12)),
            //           child: BackdropFilter(
            //             filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            //             child: Container(
            //               padding: const EdgeInsets.all(8),
            //               height: 60,
            //               decoration: const BoxDecoration(
            //                 color: Colors.transparent,
            //                 borderRadius: BorderRadius.all(Radius.circular(12)),
            //                 border: Border.fromBorderSide(
            //                   BorderSide(
            //                     color: Colors.grey,
            //                     width: 0.3,
            //                   ),
            //                 ),
            //               ),
            //               child: Row(
            //                 mainAxisSize: MainAxisSize.min,
            //                 children: [
            //                   TextButton(
            //                     child: const Text("Calculator"),
            //                     onPressed: () {
            //                       _viewModel.toggleWidgetVisibility(0);
            //                     },
            //                   ),
            //                   TextButton(
            //                     child: const Text("ContactPage"),
            //                     onPressed: () {
            //                       _viewModel.toggleWidgetVisibility(1);
            //                     },
            //                   ),
            //                 ],
            //               ),
            //             ),
            //           ),
            //         ),
            //       ),
            //       const SizedBox(height: 12.0)
            //     ],
            //   ),
            // ],

            children: [
              Positioned(
                left: position.dx,
                top: position.dy,
                child: Draggable(
                  data: position,
                  feedback: currentWidget,
                  childWhenDragging: Container(),
                  child: currentWidget,
                  onDragEnd: (details) {
                    setState(() {
                      position = details.offset;
                    });
                  },
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

class TesteDragIconsViewModel extends ChangeNotifier {
  List<Widget> apps = [];

  List<DraggableWidget> widgets = [
    DraggableWidget(
      id: 'calculator',
      widget: Calculator(maximizado: ValueNotifier<bool>(false)),
      position: const Offset(100, 100),
    ),
    DraggableWidget(
      id: 'contact',
      widget: const ContactPage(),
      position: const Offset(100, 100),
    ),
  ];

  // void addApp(Widget app) {
  //   apps.add(app);
  //   notifyListeners();
  // }

  void removeApp(Widget app) {
    apps.remove(app);
    notifyListeners();
  }

  void toggleWidgetVisibility(int index) {
    widgets[index].isVisible = !widgets[index].isVisible;
    notifyListeners();
  }

  void bringToFront(int index) {
    final widget = widgets.removeAt(index);
    widgets.add(widget);
    notifyListeners();
  }
}
