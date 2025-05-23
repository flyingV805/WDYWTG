import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wdywtg/features/featureUpdater/model/weather_update_result.dart';
import 'package:wdywtg/features/featureUpdater/repository/update_data_repository.dart';

import '../../../core/database/dao/cached_weather_dao.dart';
import '../../../core/log/loger.dart';
import '../../../core/mapper/place_weather_mapper.dart';
import '../../../core/openMeteo/open_meteo_client.dart';

class UpdateDataRepositoryImpl extends UpdateDataRepository {

  static const _weatherUpdatePeriod = 8 * 60 * 60;
  static final String _logTag = 'UpdateDataRepositoryImpl';

  final _preference = GetIt.I.get<SharedPreferencesAsync>();
  final _cachedWeatherDao = GetIt.I.get<CachedWeatherDao>();
  final _openMeteoClient = GetIt.I.get<OpenMeteoClient>();

  @override
  Future<WeatherUpdateResult> updateCachedWeather() async {

    final cachedWeatherList = await _cachedWeatherDao.getAllWeather();
    // datetime to check weather actuality, seconds
    final currentTime = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    for (var cachedWeather in cachedWeatherList) {
      if( (currentTime - cachedWeather.updateTime) > _weatherUpdatePeriod ){
        try{
          final forecast = await _openMeteoClient.getForecast(cachedWeather.latitude, cachedWeather.longitude);
          Log().w(_logTag, 'UPDATE RESULT ${forecast.toJson().toString()}');

          final weatherDto = mapFromNetwork(forecast, cachedWeather.placeId, cachedWeather.latitude, cachedWeather.longitude);
          _cachedWeatherDao.updateWeather(weatherDto);
        }catch(e){
          // add to update errors
          Log().i(_logTag, e.toString());
          return Error();
        }


      }
    }

    await _preference.setInt('lastUpdateTime', DateTime.now().millisecondsSinceEpoch );
    return Success();
  }

  @override
  Future<int> lastUpdateTime() async {
    final lastUpdateTime = await _preference.getInt('lastUpdateTime') ?? 0;
    return lastUpdateTime;
  }

  @override
  void dispose() {}

}