import 'package:flutter/material.dart';

import '../../desktop/viewmodel/desktop_view_model.dart';
import 'square_mobile_widget.dart';

class WeatherSquareWidget extends StatelessWidget {
  final DesktopViewModel viewModel;

  final Color _gradientTopWeatherWidget = const Color(0xFF0A4682);
  final Color _gradientBottomWeatherWidget = const Color(0xFF5187C0);

  WeatherSquareWidget({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: viewModel,
      builder: (_, __) {
        return SizedBox(
          child: viewModel.weatherResponseModel != null
              ? SquareMobileWidget(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: weatherSquareBoxDecoration(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          viewModel.weatherResponseModel!.name!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        // const SizedBox(height: 8),
                        Text(
                          '${(viewModel.weatherResponseModel!.main!.temp - 273.15).toStringAsFixed(1)}°C',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        Image.network(
                          "https://openweathermap.org/img/wn/${viewModel.weatherResponseModel!.weather!.first.icon}@2x.png",

                          width: 50,
                          height: 50,
                          // color: Colors.red,
                        ),
                        Text(
                          "Máx ${(viewModel.weatherResponseModel!.main!.tempMax - 273.15).toStringAsFixed(1)}° Mín ${(viewModel.weatherResponseModel!.main!.tempMin - 273.15).toStringAsFixed(1)}°",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : SquareMobileWidget(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: weatherSquareBoxDecoration(),
                    child: const CircularProgressIndicator(),
                  ),
                ),
        );
      },
    );
  }

  BoxDecoration weatherSquareBoxDecoration() {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          _gradientTopWeatherWidget,
          _gradientBottomWeatherWidget,
        ],
      ),
    );
  }
}
