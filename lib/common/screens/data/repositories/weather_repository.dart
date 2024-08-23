import 'dart:convert';

import '../../../domain/entities/weather_response_model.dart';
import '../external/http_client.dart';

class WeatherRepositorySecond {
  final IHttpClient _client;

  WeatherRepositorySecond(this._client);

  Future<WeatherResponseModel> execute(double? latitude, double? longitude) async {
    try {
      final response =
          await _client.get("https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=7d3dd547d912adeb4cc3760593729c63");

      var json = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return WeatherResponseModel.fromJson(json);
      } else {
        throw Exception(json['message']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
