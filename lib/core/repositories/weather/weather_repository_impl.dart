import 'package:dio/dio.dart';
import 'package:wdywtg/features/featureFind/model/place_suggestion.dart';
import 'package:wdywtg/commonModel/place_weather.dart';
import 'package:wdywtg/core/repositories/weather/weather_repository.dart';

import '../../log/loger.dart';
import '../../openMeteo/open_geocode_client.dart';
import '../../openMeteo/open_meteo_client.dart';


class WeatherRepositoryImpl extends WeatherRepository {

  static final String _logTag = 'WeatherRepositoryImpl';
  final _openMeteoClient = OpenMeteoClient(Dio());

  @override
  Future<PlaceWeather> getWeather() async {
    _openMeteoClient.getForecast(51, 69);
    throw UnimplementedError();
  }

  @override
  void dispose() {}

}