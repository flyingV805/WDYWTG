import 'package:dio/dio.dart';
import 'package:wdywtg/features/featureMain/domain/model/place_suggestion.dart';
import 'package:wdywtg/features/featureMain/domain/model/place_weather.dart';
import 'package:wdywtg/features/featureMain/repository/weather/weather_repository.dart';

import '../../../../core/log/loger.dart';
import '../../../../core/openMeteo/open_geocode_client.dart';
import '../../../../core/openMeteo/open_meteo_client.dart';


class WeatherRepositoryImpl extends WeatherRepository {

  static final String _logTag = 'WeatherRepositoryImpl';
  final _openMeteoClient = OpenMeteoClient(Dio());
  final _openGeocodeClient = OpenGeocodeClient(Dio());

  @override
  Future<PlaceWeather> getWeather() async {
    _openMeteoClient.getForecast(51, 69);
    throw UnimplementedError();
  }

  @override
  void dispose() {}

  @override
  Future<List<PlaceSuggestion>> findSuggestions(String input) async {
    try{
      final result = _openGeocodeClient.getAutocomplete(input);
      return (await result).results.map(
        (item) => PlaceSuggestion(
          placeName: item.name,
          placeAdmin: item.generateAdminString(),
          placeCountryCode: item.countryCode,
          latitude: item.latitude,
          longitude: item.longitude,
          timezone: item.timezone
        )
      ).toList();
    }catch(e){
      Log().w(_logTag, e.toString());
      return [];
    }

  }

}