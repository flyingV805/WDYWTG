import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wdywtg/core/database/app_database.dart';
import 'package:wdywtg/core/database/dao/ai_advice_dao.dart';
import 'package:wdywtg/core/database/dao/cached_weather_dao.dart';
import 'package:wdywtg/core/database/dao/saved_place_dao.dart';
import 'package:wdywtg/core/gemini/gemini_client.dart';
import 'package:wdywtg/core/openCage/open_cage_client.dart';
import 'package:wdywtg/core/openMeteo/open_geocode_client.dart';
import 'package:wdywtg/core/unsplash/unsplash_client.dart';

import '../core/openMeteo/open_meteo_client.dart';
import '../core/userSession/user_session.dart';
import '../features/featureUpdater/info_updater.dart';
import '../features/featureUserLocation/user_location_notifier.dart';

// App's DI Graph
Future<void> initDI() async {

  // core
  final database = await $FloorAppDatabase.databaseBuilder('app_database1.db').build();
  GetIt.I.registerSingleton<SavedPlaceDao>(database.placesDao);
  GetIt.I.registerSingleton<CachedWeatherDao>(database.weatherDao);
  GetIt.I.registerSingleton<AiAdviceDao>(database.aiAdviceDao);
  GetIt.I.registerSingleton<UserSession>(UserSession());
  GetIt.I.registerSingleton<SharedPreferencesAsync>(SharedPreferencesAsync());

  final dio = Dio();
  GetIt.I.registerFactory<OpenMeteoClient>(() => OpenMeteoClient(dio));
  GetIt.I.registerFactory<OpenGeocodeClient>(() => OpenGeocodeClient(dio));
  GetIt.I.registerFactory<OpenCageClient>(() => OpenCageClient(dio));
  GetIt.I.registerFactory<UnsplashClient>(() => UnsplashClient(dio));
  GetIt.I.registerLazySingleton<GeminiClient>(() => GeminiClient());

  GetIt.I.registerSingleton<UserLocationFeatureState>(UserLocationFeatureState());
  GetIt.I.registerLazySingleton<InfoUpdater>(() => InfoUpdater());

}