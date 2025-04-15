import '../abstract/repository.dart';
import '../../../features/featureFind/model/place_suggestion.dart';
import '../../../commonModel/place_weather.dart';

abstract class WeatherRepository extends Repository {

  Future<PlaceWeather> getWeather();

}