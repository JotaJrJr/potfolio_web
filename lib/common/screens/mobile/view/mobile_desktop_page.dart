import 'package:flutter/material.dart';
import 'package:portfolio_web/common/external/http_client_impl.dart';
import 'package:portfolio_web/common/screens/calculadora/view/mobile_calculator.dart';
import 'package:portfolio_web/common/screens/contacts/view/mobile_contact_page.dart';
import 'package:portfolio_web/common/utils/icons_app.dart';

import '../../data/repositories/weather_repository.dart';
import '../../desktop/viewmodel/desktop_view_model.dart';
import '../widgets/battery_widget.dart';
import '../widgets/duolingo_home_screen_widget.dart';
import '../widgets/mobile_app_widget.dart';
import '../widgets/weather_square_widget.dart';

class MobileDesktopPage extends StatefulWidget {
  const MobileDesktopPage({super.key});

  @override
  State<MobileDesktopPage> createState() => _MobileDesktopPageState();
}

class _MobileDesktopPageState extends State<MobileDesktopPage> {
  late DesktopViewModel _viewModel;

  final Color _gradientTopWeatherWidget = const Color(0xFF0A4682);
  final Color _gradientBottomWeatherWidget = const Color(0xFF5187C0);

  @override
  void initState() {
    super.initState();
    _viewModel = DesktopViewModel(
      weatherRepository: WeatherRepositorySecond(HttpClientImpl()),
    );
    _viewModel.getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(IconsApp.backgroundImage),
                fit: BoxFit.cover,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (!_viewModel.assistiveTouchExpanded) {
                _viewModel.assistiveTouchToggleExpanded();
              }
            },
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 19),
                  child: Row(
                    children: [
                      StreamBuilder<DateTime>(
                        stream: _viewModel.timeStream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                              _viewModel.formatTime(snapshot.data!),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                      const Spacer(),
                      const Icon(Icons.wifi, color: Colors.white, size: 20),
                      const SizedBox(width: 5),
                      const BatteryWidget(),
                    ],
                  ),
                ),
                Expanded(
                  child: PageView(
                    children: [
                      buildAppRow(),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: DuolingoHomeScreenWidget(),
                      ),
                      buildAppRow(),
                      buildAppRow(),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: const EdgeInsets.all(4.0),
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                      border: Border.fromBorderSide(BorderSide(
                        color: Colors.grey,
                        width: 0.3,
                      )),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        MobileAppWidget(
                          name: "Nome",
                          assetName: IconsApp.contact,
                          onPressed: () {},
                          hasName: false,
                        ),
                        MobileAppWidget(
                          name: "Nome",
                          assetName: IconsApp.calculator,
                          onPressed: () {},
                          hasName: false,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
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
                                Navigator.canPop(context) ? Navigator.pop(context) : null;
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
    );
  }

  Widget buildAppRow() {
    return Container(
      padding: const EdgeInsets.only(
        left: 14,
        top: 14,
        right: 14,
      ),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DuolingoHomeScreenWidget(),
          const SizedBox(height: 4),
          const Align(
            child: Text(
              "Duolingo",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              WeatherSquareWidget(viewModel: _viewModel),
              MobileAppWidget(
                name: "Contatos",
                assetName: IconsApp.contact,
                onPressed: () {
                  // _createRoute(MobileContactPage());
                  Navigator.push(
                    context,
                    _createRoute(MobileContactPage(
                      dx: _viewModel.assistiveTouchPosition.dx,
                      dy: _viewModel.assistiveTouchPosition.dy,
                    )),
                  ).then((value) {
                    if (value != null && value is Offset) {
                      setState(() {
                        _viewModel.assistiveTouchPosition = value;
                      });
                    }
                  });
                },
              ),
              MobileAppWidget(
                name: "Calculadora",
                assetName: IconsApp.calculator,
                onPressed: () {
                  Navigator.push(
                      context,
                      _createRoute(MobileCalculator(
                        dx: _viewModel.assistiveTouchPosition.dx,
                        dy: _viewModel.assistiveTouchPosition.dy,
                      )));
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  Route _createRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset(0.0, 0.0);
        const curve = Curves.easeOut;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }
}

class AssistiveTouchWidget extends StatelessWidget {
  final VoidCallback onTap;

  const AssistiveTouchWidget({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: () {},
      child: CircleAvatar(
        backgroundColor: Colors.white.withOpacity(0.3),
        radius: 30,
        child: CircleAvatar(
          backgroundColor: Colors.white.withOpacity(0.6),
          radius: 25,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Colors.white.withOpacity(0.9),
              radius: 20,
            ),
          ),
        ),
      ),
    );
  }
}
