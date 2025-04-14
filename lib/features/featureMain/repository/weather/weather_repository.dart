import '../../../../core/repositories/repository.dart';
import '../../domain/model/place_suggestion.dart';
import '../../domain/model/place_weather.dart';

abstract class WeatherRepository extends Repository {

  Future<PlaceWeather> getWeather();
  Future<List<PlaceSuggestion>> findSuggestions(String input);

}