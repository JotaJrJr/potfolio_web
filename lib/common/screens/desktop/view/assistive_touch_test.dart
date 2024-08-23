import 'package:flutter/material.dart';

import '../../../utils/icons_app.dart';
import '../../calculadora/view/mobile_calculator.dart';

class AssistiveTouchTestPage extends StatefulWidget {
  const AssistiveTouchTestPage({super.key});

  @override
  State<AssistiveTouchTestPage> createState() => _AssistiveTouchTestPageState();
}

class _AssistiveTouchTestPageState extends State<AssistiveTouchTestPage> {
  Offset _assistiveTouchPosition = const Offset(0, 0);

  bool isAssistiveTouchExpanded = true;

  void _toggleAssistiveTouchExpanded() {
    setState(() {
      isAssistiveTouchExpanded = !isAssistiveTouchExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              if (!isAssistiveTouchExpanded) _toggleAssistiveTouchExpanded();
            },
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(IconsApp.backgroundImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Column(
            children: [
              GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MobileCalculator(
                              dx: _assistiveTouchPosition.dx,
                              dy: _assistiveTouchPosition.dy,
                            ))),
                child: Container(
                  height: 50,
                  width: 50,
                  color: Colors.red,
                ),
              ),
            ],
          ),

          isAssistiveTouchExpanded
              ? Positioned(
                  left: _assistiveTouchPosition.dx,
                  top: _assistiveTouchPosition.dy,
                  child: GestureDetector(
                    onLongPress: () {},
                    onTap: () {
                      _toggleAssistiveTouchExpanded();
                    },
                    child: Draggable(
                      feedback: const AssistiveTouchPageTestWidget(),
                      childWhenDragging: Container(),
                      onDraggableCanceled: (velocity, offset) {
                        setState(() {
                          _assistiveTouchPosition = offset;
                        });
                      },
                      child: const AssistiveTouchPageTestWidget(),
                    ),
                  ),
                )
              : Positioned(
                  left: (MediaQuery.of(context).size.width * 0.5) - 40,
                  top: (MediaQuery.of(context).size.height * 0.5) - 60,
                  child: Container(
                    height: 120,
                    width: 80,
                    color: Colors.white.withOpacity(0.5),
                    child: Column(
                      children: [
                        TextButton(
                          onPressed: () {
                            _toggleAssistiveTouchExpanded();
                            Navigator.canPop(context) ? Navigator.pop(context) : null;
                          },
                          child: const Text("Voltar"),
                        ),
                      ],
                    ),
                  ),
                ),

          // Positioned(
          //   left: _assistiveTouchPosition.dx,
          //   top: _assistiveTouchPosition.dy,
          //   child: GestureDetector(
          //     onLongPress: () {},
          //     onTap: () {},
          //     child: Draggable(
          //       feedback: AssistiveTouchPageTestWidget(),
          //       childWhenDragging: Container(),
          //       onDraggableCanceled: (velocity, offset) {
          //         setState(() {
          //           _assistiveTouchPosition = offset;
          //         });
          //       },
          //       child: AssistiveTouchPageTestWidget(),
          //     ),
          //   ),
          // ),
          // Positioned(
          //   left: (MediaQuery.of(context).size.width * 0.5) - 40,
          //   top: (MediaQuery.of(context).size.height * 0.5) - 60,
          //   child: Container(
          //     height: 120,
          //     width: 80,
          //     color: Colors.white.withOpacity(0.5),
          //     child: const Column(
          //       children: [
          //         Text("Voltar"),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

class AssistiveTouchPageTestWidget extends StatelessWidget {
  const AssistiveTouchPageTestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 30,
      backgroundColor: Colors.white.withOpacity(0.3),
      child: CircleAvatar(
        radius: 25,
        backgroundColor: Colors.white.withOpacity(0.4),
        child: CircleAvatar(
          radius: 20,
          backgroundColor: Colors.white.withOpacity(0.5),
        ),
      ),
    );
  }
}
