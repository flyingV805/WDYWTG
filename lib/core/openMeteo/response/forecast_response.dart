import 'package:json_annotation/json_annotation.dart';
part 'forecast_response.g.dart';

@JsonSerializable()
class ForecastResponse {

  ForecastResponse({
    required this.current,
    required this.daily
  });

  factory ForecastResponse.fromJson(Map<String, dynamic> json) => _$ForecastResponseFromJson(json);

  @JsonKey(name: 'current') CurrentWeather? current;
  @JsonKey(name: 'daily') DailyWeather? daily;

  Map<String, dynamic> toJson() => _$ForecastResponseToJson(this);

}

@JsonSerializable()
class CurrentWeather {

  @JsonKey(name: 'time') String time;
  @JsonKey(name: 'interval') int interval;
  @JsonKey(name: 'temperature_2m') double temperature;
  @JsonKey(name: 'weather_code') int code;

  CurrentWeather({required this.time, required this.interval, required this.temperature, required this.code});

  factory CurrentWeather.fromJson(Map<String, dynamic> json) => _$CurrentWeatherFromJson(json);
  Map<String, dynamic> toJson() => _$CurrentWeatherToJson(this);

}


@JsonSerializable()
class DailyWeather {

  @JsonKey(name: 'time') List<String> time;
  @JsonKey(name: 'weather_code') List<int> code;
  @JsonKey(name: 'temperature_2m_max') List<double> temperatureMax;
  @JsonKey(name: 'temperature_2m_min') List<double> temperatureMin;

  DailyWeather({required this.time, required this.code, required this.temperatureMax, required this.temperatureMin});

  factory DailyWeather.fromJson(Map<String, dynamic> json) => _$DailyWeatherFromJson(json);
  Map<String, dynamic> toJson() => _$DailyWeatherToJson(this);

}