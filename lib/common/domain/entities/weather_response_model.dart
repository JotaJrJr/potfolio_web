class WeatherResponseModel {
  final CoordResponseModel? coord;
  final List<WeatherInfoResponseModel>? weather;
  final String? base;
  final MainResponseModel? main;
  final int? visibility;
  final WindResponseModel? wind;
  final RainResponseModel? rain;
  final CloudsResponseModel? clouds;
  final int? dt;
  final SysResponseModel? sys;
  final int? timezone;
  final int? id;
  final String? name;
  final int? cod;

  WeatherResponseModel({
    this.coord,
    this.weather,
    this.base,
    this.main,
    this.visibility,
    this.wind,
    this.rain,
    this.clouds,
    this.dt,
    this.sys,
    this.timezone,
    this.id,
    this.name,
    this.cod,
  });

  factory WeatherResponseModel.fromJson(Map<String, dynamic> json) {
    return WeatherResponseModel(
      coord: CoordResponseModel.fromJson(json['coord']),
      weather: (json['weather'] as List).map((e) => WeatherInfoResponseModel.fromJson(e)).toList(),
      base: json['base'],
      main: MainResponseModel.fromJson(json['main']),
      visibility: json['visibility'],
      wind: WindResponseModel.fromJson(json['wind']),
      // rain: RainResponseModel.fromJson(json['rain']), // fia da puta com erro
      clouds: CloudsResponseModel.fromJson(json['clouds']),
      dt: json['dt'],
      // sys: SysResponseModel.fromJson(json['sys']), // fia da puta também com erro
      timezone: json['timezone'],
      id: json['id'],
      name: json['name'],
      cod: json['cod'],
    );
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'coord': coord.toJson(),
  //     'weather': weather.map((e) => e.toJson()).toList(),
  //     'base': base,
  //     'main': main.toJson(),
  //     'visibility': visibility,
  //     'wind': wind.toJson(),
  //     'rain': rain.toJson(),
  //     'clouds': clouds.toJson(),
  //     'dt': dt,
  //     'sys': sys.toJson(),
  //     'timezone': timezone,
  //     'id': id,
  //     'name': name,
  //     'cod': cod,
  //   };
  // }
}

class CoordResponseModel {
  final double? long;
  final double? lat;

  CoordResponseModel({
    required this.long,
    required this.lat,
  });

  factory CoordResponseModel.fromJson(Map<String, dynamic> json) {
    return CoordResponseModel(
      long: json['lon'],
      lat: json['lat'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lon': long,
      'lat': lat,
    };
  }
}

class WeatherInfoResponseModel {
  final int? id;
  final String? main;
  final String? description;
  final String? icon;

  WeatherInfoResponseModel({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  factory WeatherInfoResponseModel.fromJson(Map<String, dynamic> json) {
    return WeatherInfoResponseModel(
      id: json['id'],
      main: json['main'],
      description: json['description'],
      icon: json['icon'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'main': main,
      'description': description,
      'icon': icon,
    };
  }
}

class MainResponseModel {
  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int humidity;
  final int? seaLevel;
  final int? grndLevel;

  MainResponseModel({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
    required this.seaLevel,
    required this.grndLevel,
  });

  factory MainResponseModel.fromJson(Map<String, dynamic> json) {
    return MainResponseModel(
      temp: json['temp'],
      feelsLike: json['feels_like'],
      tempMin: json['temp_min'],
      tempMax: json['temp_max'],
      pressure: json['pressure'],
      humidity: json['humidity'],
      seaLevel: json['sea_level'],
      grndLevel: json['grnd_level'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'temp': temp,
      'feels_like': feelsLike,
      'temp_min': tempMin,
      'temp_max': tempMax,
      'pressure': pressure,
      'humidity': humidity,
      'sea_level': seaLevel,
      'grnd_level': grndLevel,
    };
  }
}

class WindResponseModel {
  final double speed;
  final int deg;
  final double gust;

  WindResponseModel({
    required this.speed,
    required this.deg,
    required this.gust,
  });

  factory WindResponseModel.fromJson(Map<String, dynamic> json) {
    return WindResponseModel(
      speed: json['speed'],
      deg: json['deg'],
      gust: json['gust'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'speed': speed,
      'deg': deg,
      'gust': gust,
    };
  }
}

class RainResponseModel {
  final double? oneHour;

  RainResponseModel({
    required this.oneHour,
  });

  factory RainResponseModel.fromJson(Map<String, dynamic> json) {
    return RainResponseModel(
      oneHour: json['1h'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '1h': oneHour,
    };
  }
}

class CloudsResponseModel {
  final int all;

  CloudsResponseModel({
    required this.all,
  });

  factory CloudsResponseModel.fromJson(Map<String, dynamic> json) {
    return CloudsResponseModel(
      all: json['all'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'all': all,
    };
  }
}

class SysResponseModel {
  final int type;
  final int id;
  final String country;
  final int sunrise;
  final int sunset;

  SysResponseModel({
    required this.type,
    required this.id,
    required this.country,
    required this.sunrise,
    required this.sunset,
  });

  factory SysResponseModel.fromJson(Map<String, dynamic> json) {
    return SysResponseModel(
      type: json['type'],
      id: json['id'],
      country: json['country'],
      sunrise: json['sunrise'],
      sunset: json['sunset'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'id': id,
      'country': country,
      'sunrise': sunrise,
      'sunset': sunset,
    };
  }
}
