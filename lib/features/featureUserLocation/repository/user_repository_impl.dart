import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wdywtg/core/database/dto/saved_place_dto.dart';
import 'package:wdywtg/features/featureUserLocation/model/place_setup_response.dart';
import 'package:wdywtg/features/featureUserLocation/repository/user_repository.dart';

import '../../../core/database/constants.dart';
import '../../../core/database/dao/cached_weather_dao.dart';
import '../../../core/database/dao/saved_place_dao.dart';
import '../../../core/log/loger.dart';
import '../../../core/mapper/place_weather_mapper.dart';
import '../../../core/openCage/open_cage_client.dart';
import '../../../core/openMeteo/open_meteo_client.dart';
import '../model/user_place_profile.dart';
import 'mapper/place_mapper.dart';
import 'mapper/weather_mapper.dart';

class UserRepositoryImpl extends UserRepository {

  final _preferences = SharedPreferencesAsync();

  final _savedPlaceDao = GetIt.I.get<SavedPlaceDao>();
  final _cachedWeatherDao = GetIt.I.get<CachedWeatherDao>();
  final _openCageClient = GetIt.I.get<OpenCageClient>();
  final _openMeteoClient = GetIt.I.get<OpenMeteoClient>();

  static final String _logTag = 'UserRepositoryImpl';

  @override
  Future<bool> needAskForLocation() async {
    final result = await _preferences.getBool('needAskForLocation') ?? true;
    return result;
  }

  @override
  void setNeedAskForLocation(bool value) {
    _preferences.setBool('needAskForLocation', value);
  }

  @override
  void setShowUserLocation(bool value) {
    _preferences.setBool('showUserLocation', value);
  }

  @override
  Future<bool> showUserLocation() async {
    final result = await _preferences.getBool('showUserLocation') ?? false;
    return result;
  }

  @override
  Future<PlaceSetupResponse> updateUserPlace(double latitude, double longitude) async {

    // step 0 - check if place is changed


    try {
      final reverseGeocodeQuery = '$latitude+$longitude';
      final geocodeResult = await _openCageClient.findPlace(reverseGeocodeQuery, dotenv.get('OPEN_CAGE_API_KEY'));
      final userPlaceDto = mapFromGeocode(geocodeResult.results.first, latitude, longitude);
      _savedPlaceDao.insertPlace(userPlaceDto);
    } catch (e){
      Log().w(_logTag, e.toString());
    }

    try{
      final weather = await _openMeteoClient.getForecast(latitude, longitude);
      final weatherDto = mapFromNetwork(weather, Constants.userPlaceId, latitude, longitude);
      _cachedWeatherDao.insertWeather(weatherDto);
    }catch(e){
      Log().w(_logTag, e.toString());
    }

    return Success();

  }

  @override
  Stream<UserPlaceProfile?> userPlaceLive() {

    final placesStream = _savedPlaceDao.placeLive(Constants.userPlaceId);
    final weatherStream = _cachedWeatherDao.placeWeatherLive(Constants.userPlaceId);

    return CombineLatestStream.combine2(
      placesStream.startWith(null),
      weatherStream.startWith(null),
      (place, weather) {
        if (place == null) return null;
        return UserPlaceProfile(
          placeName: place.placeName,
          placeCountryCode: place.placeCountryCode,
          placePictureUrl: place.placePictureUrl,
          placePictureAuthor: place.placePictureAuthor,
          weather: mapWeatherDtoToModel(weather)
        );
      }
    );

  }

  @override
  void dispose() {}

}