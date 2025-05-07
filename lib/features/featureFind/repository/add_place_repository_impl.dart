import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:wdywtg/core/database/dao/ai_advice_dao.dart';
import 'package:wdywtg/core/database/dao/cached_weather_dao.dart';
import 'package:wdywtg/core/gemini/gemini_client.dart';
import 'package:wdywtg/core/unsplash/unsplash_client.dart';
import 'package:wdywtg/features/featureFind/model/add_result.dart';
import 'package:wdywtg/features/featureFind/model/place_suggestion.dart';
import '../../../core/database/dao/saved_place_dao.dart';
import '../../../core/database/dto/saved_place_dto.dart';
import '../../../core/log/loger.dart';
import '../../../core/mapper/place_weather_mapper.dart';
import '../../../core/openMeteo/open_meteo_client.dart';
import '../../../core/unsplash/image_palette.dart';
import '../../../core/userSession/user_session.dart';
import 'add_place_repository.dart';

class AddPlaceRepositoryImpl extends AddPlaceRepository {

  final _savedPlaceDao = GetIt.I.get<SavedPlaceDao>();
  final _cachedWeatherDao = GetIt.I.get<CachedWeatherDao>();
  final _aiAdvicesDao = GetIt.I.get<AiAdviceDao>();
  final _userSession = GetIt.I.get<UserSession>();

  final _openMeteoClient = GetIt.I.get<OpenMeteoClient>();
  final _unsplashClient = GetIt.I.get<UnsplashClient>();
  final _geminiClient = GetIt.I.get<GeminiClient>();

  static final String _logTag = 'AddPlaceRepositoryImpl';

  @override
  Future<AddResult> addSavedPlace(PlaceSuggestion suggestion) async {

    Log().d(_logTag, 'addSavedPlace - ${suggestion.toString()} ${suggestion.timezone}');

    final placeDto = _createFromSuggestion(suggestion);

    // save to database
    try{
      _userSession.lastAddedId = placeDto.id;
      await _savedPlaceDao.insertPlace(placeDto);
    }catch(e){
      Log().d(_logTag, 'insertPlace - ${e.toString()}');
      return AlreadyAddedError();
    }

    // get weather
    final weatherResult = await _setPlaceWeather(suggestion);
    if(!weatherResult){ return WeatherError(); }

    // get place image
    final imageResult = await _setPlaceImage(suggestion);
    if(!imageResult){ return ImageError(); }

    // get ai advices
    final advicesResult = await _setPlaceAdvices(suggestion);
    if(!advicesResult){ return AdvicesError(); }

    return Success();

  }

  @override
  Future<AddResult> retryFromWeather(PlaceSuggestion suggestion) async {

    final weatherResult = await _setPlaceWeather(suggestion);
    if(!weatherResult){ return WeatherError(); }

    // get place image
    final imageResult = await _setPlaceImage(suggestion);
    if(!imageResult){ return ImageError(); }

    // get ai advices
    final advicesResult = await _setPlaceAdvices(suggestion);
    if(!advicesResult){ return AdvicesError(); }

    return Success();

  }

  @override
  Future<AddResult> retryFromImage(PlaceSuggestion suggestion) async {
    // get place image
    final imageResult = await _setPlaceImage(suggestion);
    if(!imageResult){ return ImageError(); }

    // get ai advices
    final advicesResult = await _setPlaceAdvices(suggestion);
    if(!advicesResult){ return AdvicesError(); }

    return Success();
  }

  @override
  Future<AddResult> retryFromAdvices(PlaceSuggestion suggestion) async {

    // get ai advices
    final advicesResult = await _setPlaceAdvices(suggestion);
    if(!advicesResult){ return AdvicesError(); }

    return Success();
  }
  /* * */

  SavedPlaceDto _createFromSuggestion(PlaceSuggestion suggestion){
    return SavedPlaceDto(
      suggestion.placeId,
      suggestion.placeName,
      suggestion.timezone,
      suggestion.placeCountryCode,
      null,
      null,
      null,
      null,
      suggestion.latitude,
      suggestion.longitude,
      true,
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
    );
  }

  Future<bool> _setPlaceWeather(PlaceSuggestion suggestion) async {
    try{
      final weather = await _openMeteoClient.getForecast(suggestion.latitude, suggestion.longitude);
      final weatherDto = mapFromNetwork(weather, suggestion.placeId, suggestion.latitude, suggestion.longitude);
      _cachedWeatherDao.insertWeather(weatherDto);
    }catch(e){
      return false;
    }

    return true;
  }

  Future<bool> _setPlaceImage(PlaceSuggestion suggestion) async {
    try{
      final image = await _unsplashClient.getPicture(
        '${suggestion.placeName}, ${suggestion.placeCountryCode.toUpperCase()}',
        dotenv.get('UNSPLASH_API_ACCESS_KEY')
      );
      final palette = await findTextPalette(image.results.first.urls.thumb);
      await _savedPlaceDao.updatePlacePicture(
        suggestion.placeId,
        image.results.first.urls.regular,
        image.results.first.user.name,
        'https://unsplash.com/@${image.results.first.user.username}',
        palette.index
      );
    }catch(e){
      return false;
    }

    return true;
  }

  Future<bool> _setPlaceAdvices(PlaceSuggestion suggestion) async {

    try{
      final userPlace = await _savedPlaceDao.getUserPlace();
      final isCountryDifferent =
          userPlace?.placeCountryCode.toUpperCase() != suggestion.placeCountryCode.toUpperCase();
      final placeString = '${suggestion.placeName}, ${suggestion.placeCountryCode}';
      final advices = await _geminiClient.generatePlaceAdvices(suggestion.placeId, placeString, isCountryDifferent);
      _aiAdvicesDao.insertAdvices(advices);
    }catch(e){
      return false;
    }

    return true;
  }

  @override
  void dispose() {}
}