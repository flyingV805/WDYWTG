import 'package:dio/dio.dart';
import 'package:wdywtg/features/featureMain/model/place_weather.dart';
import 'package:wdywtg/features/featureMain/repository/weather/weather_repository.dart';

import '../../../../core/openMeteo/open_meteo_client.dart';


class WeatherRepositoryImpl extends WeatherRepository {

  final _openMeteoClient = OpenMeteoClient(Dio());

  @override
  Future<PlaceWeather> getWeather() async {
    _openMeteoClient.getForecast(51, 69);
    throw UnimplementedError();
  }

  @override
  void dispose() {}

}