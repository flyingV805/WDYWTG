import 'package:floor/floor.dart';
import 'package:wdywtg/core/database/dto/cached_weather_dto.dart';

@dao
abstract class CachedWeatherDao {

  @Query('SELECT * FROM CachedWeatherDto')
  Future<List<CachedWeatherDto>> getAllWeather();

  @Query('SELECT * FROM CachedWeatherDto')
  Stream<List<CachedWeatherDto>> allWeatherLive();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertWeather(CachedWeatherDto weather);
  
}