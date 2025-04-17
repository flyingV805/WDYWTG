import 'package:get_it/get_it.dart';
import 'package:wdywtg/core/database/app_database.dart';
import 'package:wdywtg/core/database/dao/ai_advice_dao.dart';
import 'package:wdywtg/core/database/dao/cached_weather_dao.dart';
import 'package:wdywtg/core/database/dao/saved_place_dao.dart';
import 'package:wdywtg/core/repositories/weather/weather_repository.dart';
import 'package:wdywtg/core/repositories/weather/weather_repository_impl.dart';

// App's DI Graph
Future<void> initDI() async {

  // core
  final database = await $FloorAppDatabase.databaseBuilder('app_database1.db').build();
  GetIt.I.registerSingleton<SavedPlaceDao>(database.placesDao);
  GetIt.I.registerSingleton<CachedWeatherDao>(database.weatherDao);
  GetIt.I.registerSingleton<AiAdviceDao>(database.aiAdviceDao);

  // repositories
  GetIt.I.registerSingleton<WeatherRepository>(WeatherRepositoryImpl());



}