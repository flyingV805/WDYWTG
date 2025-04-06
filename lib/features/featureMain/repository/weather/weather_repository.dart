import '../../../../core/repositories/repository.dart';
import '../../model/place_weather.dart';

abstract class WeatherRepository extends Repository {

  Future<PlaceWeather> getWeather();

}