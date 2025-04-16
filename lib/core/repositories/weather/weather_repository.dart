import '../abstract/repository.dart';
import '../../../commonModel/place_weather.dart';

abstract class WeatherRepository extends Repository {

  Future<PlaceWeather> getWeather();

}