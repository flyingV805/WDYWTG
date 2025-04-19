import 'package:get_it/get_it.dart';
import 'package:wdywtg/core/database/dao/ai_advice_dao.dart';
import 'package:wdywtg/core/database/dao/cached_weather_dao.dart';
import 'package:wdywtg/core/gemini/gemini_client.dart';
import 'package:wdywtg/features/featureFind/model/add_result.dart';
import 'package:wdywtg/features/featureFind/model/place_suggestion.dart';
import '../../../core/database/dao/saved_place_dao.dart';
import '../../../core/database/dto/saved_place_dto.dart';
import '../../../core/log/loger.dart';
import '../../../core/mapper/place_weather_mapper.dart';
import '../../../core/openMeteo/open_meteo_client.dart';
import 'add_place_repository.dart';

class AddPlaceRepositoryImpl extends AddPlaceRepository {

  final _savedPlaceDao = GetIt.I.get<SavedPlaceDao>();
  final _cachedWeatherDao = GetIt.I.get<CachedWeatherDao>();
  final _aiAdvicesDao = GetIt.I.get<AiAdviceDao>();

  final _openMeteoClient = GetIt.I.get<OpenMeteoClient>();


  final _geminiClient = GetIt.I.get<GeminiClient>();

  static final String _logTag = 'AddPlaceRepositoryImpl';

  @override
  Future<AddResult> addSavedPlace(PlaceSuggestion suggestion) async {

    Log().w(_logTag, 'addSavedPlace - ${suggestion.toString()} ${suggestion.timezone}');

    final placeDto = SavedPlaceDto(
      suggestion.placeId,
      suggestion.placeName,
      suggestion.timezone,
      suggestion.placeCountryCode,
      'https://example.com/berlin.jpg',
      suggestion.latitude,
      suggestion.longitude,
      DateTime.now().millisecondsSinceEpoch ~/ 1000
    );

    try{
      await _savedPlaceDao.insertPlace(placeDto);
    }catch(e){
      return AlreadyAddedError();
    }

    try{
      final weather = await _openMeteoClient.getForecast(suggestion.latitude, suggestion.longitude);
      final weatherDto = mapFromNetwork(weather, suggestion.placeId, suggestion.latitude, suggestion.longitude);
      _cachedWeatherDao.insertWeather(weatherDto);
    }catch(e){
      return WeatherError();
    }

    try{
      final advices = await _geminiClient.generatePlaceAdvices(placeDto);    
      _aiAdvicesDao.insertAdvices(advices);
    }catch(e){
      return AdvicesError();
    }

    return Success();

  }


  @override
  void dispose() {}
}