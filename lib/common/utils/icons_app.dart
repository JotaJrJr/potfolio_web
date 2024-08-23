class IconsApp {
  IconsApp._();

  static const String _assets = 'assets/icons';
  static const String _images = 'images';

  // TODO Implementar AppStore
  static const String appleStore = '$_assets/apple_store.png';

  // TODO Implementar WhatsApp
  static const String whatsApp = '$_assets/whats_app.png';

  // TODO TERMINAR CALCULADORA
  static const String calculator = '$_assets/calculator.png';

  // TODO Implementar settings
  static const String settings = '$_assets/settings.png';

  // TODO TERMINAR CONTATOS
  static const String contact = '$_assets/contacts.png';

  static const String backgroundImage = '$_assets/background_image.png';

  static const String mobileBackgroundImage = '$_assets/mobile_background_image.png';

  static const String background = '$_assets/background.png';

  static const String bottomLogoDark = '$_assets/bottom_logo_dark.svg';

  static const String entregasFalhas = '$_assets/entregas_falhas.svg';

  static const String entregasSucesso = '$_assets/entrega_sucesso.svg';

  static const String entregasRealizadas = '$_assets/entrega_realizadas.svg';

  static const String ocorrencias = '$_assets/ocorrencias.svg';

  static const String profilePicture = '$_images/profile_picture.jpeg';

  static const String coruja = '$_assets/coruja.png';
  static const String streak = '$_assets/streak.svg';
}



// import 'package:flutter/material.dart';

// import 'utils/icons_app.dart';

// class TesteDraggable extends StatefulWidget {
//   const TesteDraggable({super.key});

//   @override
//   State<TesteDraggable> createState() => _TesteDraggableState();
// }

// class _TesteDraggableState extends State<TesteDraggable> {
//   List<Color> columnColors = [Colors.red, Colors.blue, Colors.teal];
//   List<Color> rowColors = [Colors.green, Colors.yellow, Colors.purple];

//   List<AppWidget> firstList = [
//     AppWidget(
//       name: 'Apple Store',
//       assetName: IconsApp.appleStore,
//       onPressed: () => print('Apple Store'),
//     ),
//     AppWidget(
//       name: 'Calculadora',
//       assetName: IconsApp.calculator,
//       onPressed: () => print('Calculadora'),
//     ),
//     AppWidget(
//       name: 'App 3',
//       assetName: IconsApp.settings,
//       onPressed: () => print('App 3'),
//     ),
//   ];

//   List<AppWidget> secondList = [
//     AppWidget(
//       name: 'WhatsApp',
//       assetName: IconsApp.whatsApp,
//       onPressed: () => print('WhatsApp'),
//     ),
//     AppWidget(
//       name: 'Contatos',
//       assetName: IconsApp.contact,
//       onPressed: () => print('Contatos'),
//     ),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Expanded(
//             child: buildDragTarget(firstList, true),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8),
//             child: Container(
//               padding: const EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 color: Colors.black.withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: buildDragTarget(secondList, false),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildDragTarget(List<AppWidget> items, bool isColumn) {
//     return DragTarget<AppWidget>(
//       onWillAccept: (data) {
//         if (isColumn) {
//           return firstList.length > 1;
//         } else {
//           return secondList.length > 1;
//         }
//       },
//       onAccept: (app) {
//         setState(() {
//           if (isColumn) {
//             if (!firstList.contains(app)) {
//               firstList.add(app);
//               secondList.removeWhere((c) => c == app);
//             }
//           } else {
//             if (!secondList.contains(app)) {
//               secondList.add(app);
//               firstList.removeWhere((c) => c == app);
//             }
//           }
//         });
//       },
//       builder: (context, candidateData, rejectedData) {
//         return isColumn
//             ? Column(
//                 children: items.map((app) => buildDraggable(app, isColumn)).toList(),
//               )
//             : Row(
//                 children: items.map((app) => buildDraggable(app, isColumn)).toList(),
//               );
//       },
//     );
//   }

//   Widget buildDraggable(AppWidget app, bool isColumn) {
//     return Draggable<AppWidget>(
//       data: app,
//       feedback: Material(
//         child: app,
//       ),
//       childWhenDragging: Container(
//         decoration: const BoxDecoration(
//           color: Colors.white,
//         ),
//         width: 100,
//         height: 100,
//         margin: const EdgeInsets.all(4),
//       ),
//       child: Container(
//         width: 100,
//         height: 100,
//         margin: const EdgeInsets.all(4),
//       ),
//     );
//   }
// }

// class AppWidget extends StatelessWidget {
//   final String name;
//   final String assetName;
//   final Function onPressed;

//   const AppWidget({super.key, required this.name, required this.assetName, required this.onPressed});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => onPressed(),
//       child: SizedBox(
//         child: Image.asset(
//           assetName,
//           // width: 50,
//           // height: 50,
//         ),
//       ),
//     );
//   }
// }
