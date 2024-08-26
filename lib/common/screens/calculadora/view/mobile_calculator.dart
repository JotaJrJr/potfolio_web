import 'package:flutter/material.dart';
import 'package:portfolio_web/common/screens/calculadora/models/calculator_cell.dart';
import 'package:portfolio_web/common/screens/calculadora/viewmodel/calculator_view_model.dart';
import 'package:portfolio_web/common/screens/calculadora/widgets/calculator_button_widget.dart';

import '../../mobile/view/mobile_desktop_page.dart';
import '../constants/calculator_cell_views.dart';
import '../constants/calculator_cells.dart';
import '../models/calculator_cell_view.dart';

class MobileCalculator extends StatefulWidget {
  final double dx;
  final double dy;

  const MobileCalculator({super.key, required this.dx, required this.dy});

  @override
  State<MobileCalculator> createState() => _MobileCalculatorState();
}

class _MobileCalculatorState extends State<MobileCalculator> {
  late CalculatorViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = CalculatorViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: 100,
                  color: Colors.black,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      "Calculadora",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                ...smallCalculator.map((row) {
                  return Row(
                    children: row.map((cell) {
                      CalculatorCell cellResult = cell.onRender(_viewModel);
                      return Expanded(
                        flex: cell.size,
                        child: CalculatorButtonWidget(
                          text: cellResult.text,
                          color: cellResult.color,
                          onPressed: () {
                            _viewModel.executeCell(cellResult);
                          },
                        ),
                      );
                    }).toList(),
                  );
                })
              ],
            ),

            /// ASSISTIVE TOUCH
            AnimatedBuilder(
              animation: _viewModel,
              builder: (_, __) {
                return _viewModel.assistiveTouchExpanded
                    ? Positioned(
                        left: _viewModel.assistiveTouchPosition.dx,
                        top: _viewModel.assistiveTouchPosition.dy,
                        child: Draggable(
                          feedback: AssistiveTouchWidget(
                            onTap: () {
                              _viewModel.assistiveTouchToggleExpanded();
                            },
                          ),
                          childWhenDragging: Container(),
                          onDraggableCanceled: (velocity, offset) {
                            setState(() {
                              _viewModel.assistiveTouchPosition = offset;
                            });
                          },
                          child: AssistiveTouchWidget(
                            onTap: () {
                              _viewModel.assistiveTouchToggleExpanded();
                            },
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
                                  _viewModel.assistiveTouchToggleExpanded();
                                  Navigator.canPop(context) ? Navigator.pop(context, _viewModel.assistiveTouchPosition) : null;
                                },
                                child: const Text("Voltar"),
                              ),
                            ],
                          ),
                        ),
                      );
              },
            ),
          ],
        ),
      ),
    );
  }

  static List<List<CalculatorCellView>> smallCalculator = [
    [
      CalculatorCellViews.deleteButton,
      CalculatorCellView.staticButton(CalculatorCells.changeSignButton),
      CalculatorCellView.staticButton(CalculatorCells.percentageButton),
      CalculatorCellView.staticButton(CalculatorCells.divisionButton),
    ],
    [
      CalculatorCellView.staticButton(CalculatorCells.sevenButton),
      CalculatorCellView.staticButton(CalculatorCells.eightButton),
      CalculatorCellView.staticButton(CalculatorCells.nineButton),
      CalculatorCellView.staticButton(CalculatorCells.multiplicationButton),
    ],
    [
      CalculatorCellView.staticButton(CalculatorCells.fourButton),
      CalculatorCellView.staticButton(CalculatorCells.fiveButton),
      CalculatorCellView.staticButton(CalculatorCells.sixButton),
      CalculatorCellView.staticButton(CalculatorCells.subtractionButton),
    ],
    [
      CalculatorCellView.staticButton(CalculatorCells.oneButton),
      CalculatorCellView.staticButton(CalculatorCells.twoButton),
      CalculatorCellView.staticButton(CalculatorCells.threeButton),
      CalculatorCellView.staticButton(CalculatorCells.additionButton),
    ],
    [
      CalculatorCellView.staticButton(CalculatorCells.zeroButton, size: 2),
      CalculatorCellView.staticButton(CalculatorCells.dotButton),
      CalculatorCellView.staticButton(CalculatorCells.equalButton),
    ],
  ];
}

// // // ignore_for_file: prefer_const_constructors

// // import 'package:flutter/material.dart';
// // import 'package:portfolio_web/common/screens/calculadora/models/calculator_cell.dart';
// // import 'package:portfolio_web/common/screens/calculadora/viewmodel/calculator_view_model.dart';

// // import '../constants/calculator_cell_views.dart';
// // import '../constants/calculator_cells.dart';
// // import '../models/calculator_cell_view.dart';

// // class MobileCalculator extends StatelessWidget {
// //   final CalculatorViewModel viewModel;

// //   const MobileCalculator({super.key, required this.viewModel});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Material(
// //       child: Container(
// //         color: Colors.black,
// //         child: Column(
// //           children: [
// //             SizedBox(
// //               height: MediaQuery.of(context).size.height * 0.3,
// //               child: Padding(
// //                 padding: const EdgeInsets.only(right: 16),
// //                 child: Align(
// //                   alignment: Alignment.bottomRight,
// //                   child: Text(
// //                     viewModel.displayText,
// //                     style: TextStyle(
// //                       color: Colors.white,
// //                       fontSize: 24,
// //                       fontWeight: FontWeight.w600,
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //             ),

// //             Container(
// //               height: MediaQuery.of(context).size.height * 0.7,
// //               child: Column(
// //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
// //                 children: smallCalculator.map((row) {
// //                   return Row(
// //                     children: row.map((cell) {
// //                       CalculatorCell cellResult = cell.onRender(viewModel);
// //                       return Expanded(
// //                         flex: cell.size,
// //                         child: MobileCalculatorButtonWidget(
// //                           text: cellResult.text,
// //                           color: cellResult.color,
// //                           onPressed: () {
// //                             viewModel.executeCell(cellResult);
// //                           },
// //                         ),
// //                       );
// //                     }).toList(),
// //                   );
// //                 }).toList(),
// //               ),
// //             ),

// //             // Expanded(
// //             //   child: Row(
// //             //     children: ...smallCalculator.map((row) {
// //             //       return Expanded(
// //             //         child: Row(
// //             //           children: ...row.map((cell) {
// //             //             CalculatorCell cellResult = cell.onRender(viewModel);
// //             //             return Expanded(
// //             //               flex: cell.size,
// //             //               child: MobileCalculatorButtonWidget(
// //             //                 text: cellResult.text,
// //             //                 color: cellResult.color,
// //             //                 onPressed: () {
// //             //                   viewModel.executeCell(cellResult);
// //             //                 },
// //             //               ),
// //             //             );
// //             //           }).toList(),
// //             //         ),
// //             //       );
// //             //     }
// //             //   ).toList(),
// //             // ),

// //             // ...smallCalculator.map((row) {
// //             //   return Expanded(
// //             //     child: Row(
// //             //       children: row.map((cell) {
// //             //         CalculatorCell cellResult = cell.onRender(viewModel);
// //             //         return Expanded(
// //             //           flex: cell.size,
// //             //           child: MobileCalculatorButtonWidget(
// //             //             text: cellResult.text,
// //             //             color: cellResult.color,
// //             //             onPressed: () {
// //             //               viewModel.executeCell(cellResult);
// //             //             },
// //             //           ),
// //             //         );
// //             //       }).toList(),
// //             //     ),
// //             //   );
// //             // }).toList(),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   static List<List<CalculatorCellView>> smallCalculator = [
// //     [
// //       CalculatorCellViews.deleteButton,
// //       CalculatorCellView.staticButton(CalculatorCells.changeSignButton),
// //       CalculatorCellView.staticButton(CalculatorCells.percentageButton),
// //       CalculatorCellView.staticButton(CalculatorCells.divisionButton),
// //     ],
// //     [
// //       CalculatorCellView.staticButton(CalculatorCells.sevenButton),
// //       CalculatorCellView.staticButton(CalculatorCells.eightButton),
// //       CalculatorCellView.staticButton(CalculatorCells.nineButton),
// //       CalculatorCellView.staticButton(CalculatorCells.multiplicationButton),
// //     ],
// //     [
// //       CalculatorCellView.staticButton(CalculatorCells.fourButton),
// //       CalculatorCellView.staticButton(CalculatorCells.fiveButton),
// //       CalculatorCellView.staticButton(CalculatorCells.sixButton),
// //       CalculatorCellView.staticButton(CalculatorCells.subtractionButton),
// //     ],
// //     [
// //       CalculatorCellView.staticButton(CalculatorCells.oneButton),
// //       CalculatorCellView.staticButton(CalculatorCells.twoButton),
// //       CalculatorCellView.staticButton(CalculatorCells.threeButton),
// //       CalculatorCellView.staticButton(CalculatorCells.additionButton),
// //     ],
// //     [
// //       CalculatorCellView.staticButton(CalculatorCells.zeroButton, size: 2),
// //       CalculatorCellView.staticButton(CalculatorCells.dotButton),
// //       CalculatorCellView.staticButton(CalculatorCells.equalButton),
// //     ],
// //   ];
// // }

// // class MobileCalculatorButtonWidget extends StatefulWidget {
// //   final String text;
// //   final Color color;
// //   final Function onPressed;

// //   const MobileCalculatorButtonWidget({super.key, required this.text, required this.color, required this.onPressed});

// //   @override
// //   State<MobileCalculatorButtonWidget> createState() => _MobileCalculatorButtonWidgetState();
// // }

// // class _MobileCalculatorButtonWidgetState extends State<MobileCalculatorButtonWidget> {
// //   bool isPressed = false;

// //   @override
// //   Widget build(BuildContext context) {
// //     double width = MediaQuery.of(context).size.width * 0.25;
// //     return GestureDetector(
// //       onTapDown: (_) {
// //         setState(() {
// //           isPressed = true;
// //         });
// //       },
// //       onTapUp: (_) {
// //         setState(() {
// //           isPressed = false;
// //         });
// //       },
// //       onTapCancel: () {
// //         setState(() {
// //           isPressed = false;
// //         });
// //       },
// //       onTap: () => widget.onPressed(),
// //       child: Padding(
// //         padding: const EdgeInsets.all(8),
// //         child: Container(
// //           padding: const EdgeInsets.all(8),
// //           // height: ,
// //           width: width - 5,
// //           decoration: BoxDecoration(
// //             color: isPressed ? widget.color.withOpacity(0.5) : widget.color,
// //             borderRadius: BorderRadius.circular(50),
// //           ),
// //           child: Text(
// //             widget.text,
// //             textAlign: TextAlign.center,
// //             style: const TextStyle(
// //               color: Colors.white,
// //               fontSize: 32,
// //               fontWeight: FontWeight.w600,
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';

// class MobileCalculator extends StatefulWidget {
//   MobileCalculator({super.key});

//   @override
//   State<MobileCalculator> createState() => _MobileCalculatorState();
// }

// class _MobileCalculatorState extends State<MobileCalculator> {
//   String display = '0';

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       child: Container(
//         color: Colors.black,
//         child: Column(
//           children: [
//             Expanded(
//               flex: 2,
//               child: Container(
//                 alignment: Alignment.bottomRight,
//                 padding: const EdgeInsets.all(16),
//                 child: Text(
//                   display,
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 24,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//             ),
//             Expanded(
//               flex: 5,
//               child: Container(
//                 child: GridView.builder(
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 4,
//                   ),
//                   itemBuilder: (context, index) {
//                     return CalculatorButton(
//                       text: buttons[index],
//                       onTap: () {
//                         display += buttons[index];
//                       },
//                     );
//                   },
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   final List<String> buttons = [
//     'C',
//     '+/-',
//     '%',
//     '÷',
//     '7',
//     '8',
//     '9',
//     '×',
//     '4',
//     '5',
//     '6',
//     '-',
//     '1',
//     '2',
//     '3',
//     '+',
//     '0',
//     '.',
//     '=',
//     '',
//   ];
// }

// class CalculatorButton extends StatelessWidget {
//   final String text;
//   final Function onTap;

//   CalculatorButton({required this.text, required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => onTap(),
//       child: Container(
//         margin: EdgeInsets.all(8),
//         decoration: BoxDecoration(
//           color: _getColor(text),
//           borderRadius: BorderRadius.circular(50),
//         ),
//         child: Center(
//           child: Text(
//             text,
//             style: TextStyle(
//               color: _getTextColor(text),
//               fontSize: 24,
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Color _getColor(String text) {
//     if (text == 'C' || text == '+/-' || text == '%') {
//       return Colors.grey;
//     } else if (text == '÷' || text == '×' || text == '-' || text == '+') {
//       return Colors.orange;
//     } else {
//       return Colors.grey[850]!;
//     }
//   }

//   Color _getTextColor(String text) {
//     if (text == 'C' || text == '+/-' || text == '%') {
//       return Colors.black;
//     } else if (text == '÷' || text == '×' || text == '-' || text == '+') {
//       return Colors.white;
//     } else {
//       return Colors.white;
//     }
//   }
// }
