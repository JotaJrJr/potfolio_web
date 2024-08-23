import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../external/http_client_impl.dart';
import '../../../utils/icons_app.dart';
import '../../data/repositories/weather_repository.dart';
import '../viewmodel/desktop_view_model.dart';

class DesktopPage extends StatefulWidget {
  const DesktopPage({super.key});

  @override
  State<DesktopPage> createState() => _DesktopPageState();
}

class _DesktopPageState extends State<DesktopPage> {
  late DesktopViewModel _viewModel;

  Offset? _dragStartPosition;

  @override
  void initState() {
    super.initState();
    _viewModel = DesktopViewModel(weatherRepository: WeatherRepositorySecond(HttpClientImpl()));
    _viewModel.getWeather();
  }

  void startDragging(Offset position) {
    _dragStartPosition = position;
  }

  void updateDragging(Offset position) {
    if (_dragStartPosition != null) {
      final diff = position - _dragStartPosition!;
      _dragStartPosition = position;

      setState(() {
        _viewModel.widgets.forEach((element) {
          element.position += diff;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _viewModel,
      builder: (_, __) {
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
              Padding(
                padding: const EdgeInsets.only(
                  top: 40.0,
                  right: 10,
                ),
                child: Align(
                  alignment: Alignment.topRight,
                  child: _viewModel.weatherResponseModel != null
                      ? Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.grey.withOpacity(0.2),
                                Colors.black.withOpacity(0.4),
                              ],
                            ),
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _viewModel.weatherResponseModel!.name!,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  // crossAxisAlignment: CrossAxisAlignment.end,
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      '${(_viewModel.weatherResponseModel!.main!.temp - 273.15).toStringAsFixed(1)}°C',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    ),
                                    // Container(
                                    //   color: Colors.grey.withOpacity(0.3),
                                    //   padding: EdgeInsets.zero,
                                    //   child: Image.network(
                                    //     "https://openweathermap.org/img/wn/${_viewModel.weatherResponseModel!.weather!.first.icon}@2x.png",
                                    //     // "https://openweathermap.org/img/wn/02d@2x.png",
                                    //     width: 50,
                                    //     height: 50,
                                    //     // color: Colors.red,
                                    //   ),
                                    // ),
                                  ],
                                ),
                                const SizedBox(height: 2),
                                // Text(
                                //   _viewModel.weatherResponseModel!.weather!.first.description ?? "",
                                //   style: const TextStyle(
                                //     color: Colors.white,
                                //     fontSize: 14,
                                //   ),
                                // ),
                                Container(
                                  // color: Colors.grey.withOpacity(0.3),
                                  padding: EdgeInsets.zero,
                                  child: Image.network(
                                    "https://openweathermap.org/img/wn/${_viewModel.weatherResponseModel!.weather!.first.icon}@2x.png",
                                    // "https://openweathermap.org/img/wn/02d@2x.png",
                                    width: 50,
                                    height: 50,
                                    // color: Colors.red,
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      : Container(
                          width: 185,
                          height: 120,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.grey.withOpacity(0.2),
                                Colors.black.withOpacity(0.4),
                              ],
                            ),
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                          ),
                          child: const Center(child: CircularProgressIndicator()),
                        ),
                ),
              ),
              ..._viewModel.widgets.asMap().entries.map(
                (item) {
                  // final index = item.key;
                  final widget = item.value;

                  return Visibility(
                    visible: widget.isVisible,
                    child: Positioned(
                      left: widget.position.dx,
                      top: widget.position.dy,
                      child: GestureDetector(
                        onLongPress: () => _viewModel.bringToFront(widget.id),
                        child: Draggable(
                          data: widget.position,
                          feedback: widget.widget,
                          childWhenDragging: Container(),
                          child: widget.widget,
                          onDragEnd: (details) {
                            setState(() {
                              widget.position = details.offset;
                            });
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
              Column(
                children: [
                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxHeight: 30,
                    ),
                    child: Container(
                      color: Colors.grey.withOpacity(0.2),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.apple,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 4),
                          GestureDetector(
                            onTap: () {
                              _viewModel.toggleVisibility('');
                              _viewModel.bringToFront('');
                            },
                            child: const Text(
                              "Sobre",
                              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(width: 4),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
                            child: Text(
                              _viewModel.appName.value,
                              style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const Spacer(),
                          Text(
                            DateFormat('EEE d MMM').format(_viewModel.now),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
                            child: StreamBuilder<DateTime>(
                              stream: _viewModel.timeStream,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Text(
                                    _viewModel.formatTime(snapshot.data!),
                                    style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    "Under Development.",
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 12.0),
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        // height: 60,
                        decoration: const BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          border: Border.fromBorderSide(
                            BorderSide(
                              color: Colors.grey,
                              width: 0.3,
                            ),
                          ),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Powered by",
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(width: 4),
                            FlutterLogo(),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        height: 70,
                        decoration: const BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          border: Border.fromBorderSide(
                            BorderSide(
                              color: Colors.grey,
                              width: 0.3,
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: _viewModel.aplicativosBottom,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12.0)
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
