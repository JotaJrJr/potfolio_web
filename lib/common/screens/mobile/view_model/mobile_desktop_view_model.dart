import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:portfolio_web/common/domain/entities/weather_response_model.dart';
import 'package:portfolio_web/common/screens/data/repositories/weather_repository.dart';

class MobileDesktopViewModel extends ChangeNotifier {
  final WeatherRepositorySecond weatherRepository;

  MobileDesktopViewModel({required this.weatherRepository});

  final Stream<DateTime> _timeStream = Stream<DateTime>.periodic(const Duration(seconds: 1), (_) => DateTime.now());

  Stream<DateTime> get timeStream => _timeStream;

  WeatherResponseModel? weatherResponseModel;

  double? latitude;
  double? longitude;

  String formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  Future<void> getWeather() async {
    await getCurrentLocation();

    if (latitude == null || longitude == null) {
      return Future.error('Não foi possível obter a localização.');
    }

    weatherResponseModel = await weatherRepository.execute(latitude, longitude);

    notifyListeners();
  }

  Future<void> getCurrentLocation() async {
    bool isServiceEnabled;
    LocationPermission permission;

    isServiceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!isServiceEnabled) {
      return Future.error('Serviço de localização desativado.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      return Future.error('Permissão de localização negada permanentemente.');
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Permissão de localização negada permanentemente.');
    }

    Position position = await Geolocator.getCurrentPosition();

    latitude = position.latitude;
    longitude = position.longitude;
  }
}
