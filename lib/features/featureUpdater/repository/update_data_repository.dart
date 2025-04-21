import 'package:wdywtg/core/repositories/abstract/repository.dart';
import 'package:wdywtg/features/featureUpdater/model/weather_update_result.dart';

abstract class UpdateDataRepository extends Repository {

  Future<WeatherUpdateResult> updateCachedWeather();

}