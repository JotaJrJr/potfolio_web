import 'package:flutter/material.dart';

import 'common/utils/icons_app.dart';

class TesteDraggable extends StatefulWidget {
  const TesteDraggable({super.key});

  @override
  State<TesteDraggable> createState() => _TesteDraggableState();
}

class _TesteDraggableState extends State<TesteDraggable> {
  List<Color> columnColors = [Colors.red, Colors.blue, Colors.teal];
  List<Color> rowColors = [Colors.green, Colors.yellow, Colors.purple];

  List<AppWidget> firstList = [
    AppWidget(
      name: 'Apple Store',
      assetName: IconsApp.appleStore,
      onPressed: () => print('Apple Store'),
    ),
    AppWidget(
      name: 'Calculadora',
      assetName: IconsApp.calculator,
      onPressed: () => print('Calculadora'),
    ),
    AppWidget(
      name: 'App 3',
      assetName: IconsApp.settings,
      onPressed: () => print('App 3'),
    ),
  ];

  List<AppWidget> secondList = [
    AppWidget(
      name: 'WhatsApp',
      assetName: IconsApp.whatsApp,
      onPressed: () => print('WhatsApp'),
    ),
    AppWidget(
      name: 'App 2',
      assetName: IconsApp.contact,
      onPressed: () => print('App 2'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage(IconsApp.background),
          fit: BoxFit.cover,
        )),
        child: Column(
          children: [
            Expanded(
              child: buildDragTarget(firstList, true),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: buildDragTarget(secondList, false),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDragTarget(List<AppWidget> items, bool isColumn) {
    return DragTarget<AppWidget>(
      onWillAccept: (data) {
        if (isColumn) {
          return !firstList.contains(data);
        } else {
          return !secondList.contains(data);
        }
      },
      onAccept: (app) {
        setState(() {
          if (isColumn) {
            if (!firstList.contains(app)) {
              firstList.add(app);
              secondList.removeWhere((c) => c == app);
            }
          } else {
            if (!secondList.contains(app)) {
              secondList.add(app);
              firstList.removeWhere((c) => c == app);
            }
          }
        });
      },
      builder: (context, candidateData, rejectedData) {
        return Container(
          padding: const EdgeInsets.all(8),
          child: items.isEmpty
              ? const Center(
                  // TODO Alterar para outro elemento visual
                  child: Text('Arraste os ícones para cá'),
                )
              : isColumn
                  ? Column(
                      children: items.map((app) => buildDraggable(app, isColumn)).toList(),
                    )
                  : Row(
                      children: items.map((app) => buildDraggable(app, isColumn)).toList(),
                    ),
        );
      },
    );
  }

  Widget buildDraggable(AppWidget app, bool isColumn) {
    return Draggable<AppWidget>(
      data: app,
      feedback: Container(
        color: Colors.black.withOpacity(0.8),
        child: AppWidget(
          name: app.name,
          assetName: app.assetName,
          onPressed: app.onPressed,
        ),
      ),
      childWhenDragging: Container(
        color: Colors.black.withOpacity(0.5),
        child: AppWidget(
          name: app.name,
          assetName: app.assetName,
          onPressed: app.onPressed,
        ),
      ),
      child: Tooltip(
        message: app.name,
        child: AppWidget(
          name: app.name,
          assetName: app.assetName,
          onPressed: app.onPressed,
        ),
      ),
      // child: Container(
      //   color: Colors.orange,
      //   height: 50,
      //   width: 50,
      // ),
    );
  }
}

class AppWidget extends StatefulWidget {
  final String name;
  final String assetName;
  final Function onPressed;

  const AppWidget({super.key, required this.name, required this.assetName, required this.onPressed});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  bool _isHover = false;

  @override
  Widget build(BuildContext context) {
    // return MouseRegion(
    //   onEnter: (_) => setState(() => _isHover = true),
    //   onExit: (_) => setState(() => _isHover = false),
    //   child: AnimatedContainer(
    //     duration: const Duration(milliseconds: 300),
    //     width: _isHover ? 60 : 50,
    //     height: _isHover ? 60 : 50,
    //     child: Tooltip(
    //       message: widget.name,
    //       child: GestureDetector(
    //         onTap: () => widget.onPressed(),
    //         child: SizedBox(
    //           child: Image.asset(
    //             widget.assetName,
    //             width: _isHover ? 60 : 50,
    //             height: _isHover ? 60 : 50,
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
    return MouseRegion(
      onEnter: (_) => setState(() => _isHover = true),
      onExit: (_) => setState(() => _isHover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: _isHover ? 60 : 50,
        height: _isHover ? 60 : 50,
        child: Tooltip(
          message: widget.name,
          child: GestureDetector(
            onTap: () => widget.onPressed(),
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
    );
  }
}
