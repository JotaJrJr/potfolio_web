import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_web/common/screens/calculadora/view/calculator.dart';
import 'package:portfolio_web/common/screens/calculadora/view/mobile_calculator.dart';
import 'package:portfolio_web/common/screens/contacts/view/mobile_contact_page.dart';
import 'package:portfolio_web/common/screens/desktop/view/assistive_touch_test.dart';

import 'common/screens/calculadora/viewmodel/calculator_view_model.dart';
import 'common/screens/contacts/viewmodel/contact_view_model.dart';
import 'common/screens/desktop/view/desktop_page.dart';
import 'common/screens/mobile/view/mobile_desktop_page.dart';
import 'common/utils/safe_handler.dart';
import 'teste_drag_icons.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 500) {
            return const DesktopPage();
          } else {
            // return Calculator(maximizado: ValueNotifier<bool>(false));
            // return MobileCalculator();
            return const MobileDesktopPage();
            // return const MobileContactPage(
            //   dx: 0,
            //   dy: 0,
            // );
            // return const AssistiveTouchTestPage();
          }
        },
      ),
    );
  }
}
