import 'dart:math';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wdywtg/commonModel/place_picture_palette.dart';
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
import '../../../core/unsplash/image_palette.dart';
import '../../../core/unsplash/unsplash_client.dart';
import '../model/user_place_profile.dart';
import 'mapper/place_mapper.dart';
import 'mapper/weather_mapper.dart';

class UserRepositoryImpl extends UserRepository {

  final _preferences = SharedPreferencesAsync();

  final _savedPlaceDao = GetIt.I.get<SavedPlaceDao>();
  final _cachedWeatherDao = GetIt.I.get<CachedWeatherDao>();
  final _openCageClient = GetIt.I.get<OpenCageClient>();
  final _openMeteoClient = GetIt.I.get<OpenMeteoClient>();
  final _unsplashClient = GetIt.I.get<UnsplashClient>();

  static final String _logTag = 'UserRepositoryImpl';

  double _lastLatitude = 0.0;
  double _lastLongitude = 0.0;

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

    _lastLatitude = latitude;
    _lastLongitude = longitude;
    // step 0 - check if place is changed
    final userPlace = await _savedPlaceDao.getUserPlace();

    if(userPlace != null){
      final locationsDistance = _calculateDistance(
        latitude, longitude,
        userPlace.latitude, userPlace.longitude
      );
      Log().w(_logTag, 'locationsDistance - $locationsDistance');
      if(locationsDistance < 5000){ return Success(); }
    }

    try {
      final reverseGeocodeQuery = '$latitude+$longitude';
      final geocodeResult = await _openCageClient.findPlace(reverseGeocodeQuery, dotenv.get('OPEN_CAGE_API_KEY'));
      final userPlaceDto = mapFromGeocode(geocodeResult.results.first, latitude, longitude);
      _savedPlaceDao.insertPlace(userPlaceDto);
      Log().w(_logTag, 'insertPlace');
    } catch (e){
      Log().w(_logTag, e.toString());
      return FindPlaceError();
    }

    try{
      final weather = await _openMeteoClient.getForecast(latitude, longitude);
      final weatherDto = mapFromNetwork(weather, Constants.userPlaceId, latitude, longitude);
      await _cachedWeatherDao.insertWeather(weatherDto);
      // why? IDFK... but without it - wrong behavior
      _cachedWeatherDao.updateWeather(weatherDto);
      Log().w(_logTag, 'insertWeather');
    }catch(e){
      Log().w(_logTag, e.toString());
      return WeatherError();
    }

    // get place image
    try{
      final userPlace = await _savedPlaceDao.getUserPlace();
      if(userPlace == null) { return ImageError(); }
      final image = await _unsplashClient.getPicture(
        '${userPlace.placeName} city, ${userPlace.placeCountryCode.toUpperCase()}',
        dotenv.get('UNSPLASH_API_ACCESS_KEY')
      );
      final palette = await findTextPalette(image.results.first.urls.thumb);
      final updatedPlace = _updatePicture(
        userPlace,
        image.results.first.urls.regular,
        image.results.first.user.name,
        'https://unsplash.com/@${image.results.first.user.username}',
        palette
      );
      await _savedPlaceDao.updatePlace(updatedPlace);
      Log().w(_logTag, 'updatePicture');
    }catch(e){
      return ImageError();
    }

    return Success();

  }

  @override
  Future<PlaceSetupResponse> skipGeocode() async {

    try {
      final userPlaceDto = SavedPlaceDto(
        Constants.userPlaceId,
        'Your Location',
        '',
        '',
        null,
        null,
        null,
        null,
        _lastLatitude,
        _lastLongitude,
        false,
        0
      );
      _savedPlaceDao.insertPlace(userPlaceDto);
      Log().w(_logTag, 'insertPlace');
    } catch (e){
      Log().w(_logTag, e.toString());
      return FindPlaceError();
    }

    return retryFromWeather();

  }

  @override
  Future<PlaceSetupResponse> retryFromWeather() async {

    // step 0 - check if place is changed
    final userPlace = await _savedPlaceDao.getUserPlace();
    if(userPlace == null) { return FindPlaceError(); }

    try{
      final weather = await _openMeteoClient.getForecast(userPlace.latitude, userPlace.longitude);
      final weatherDto = mapFromNetwork(
        weather,
        Constants.userPlaceId,
        userPlace.latitude,
        userPlace.longitude
      );
      await _cachedWeatherDao.insertWeather(weatherDto);
      // why? IDFK... but without it - wrong behavior
      //_cachedWeatherDao.updateWeather(weatherDto);
      Log().w(_logTag, 'insertWeather');
    }catch(e){
      Log().w(_logTag, e.toString());
      return WeatherError();
    }

    // get place image
    try{
      final userPlace = await _savedPlaceDao.getUserPlace();
      if(userPlace == null) { return ImageError(); }
      final image = await _unsplashClient.getPicture(
        '${userPlace.placeName} city, ${userPlace.placeCountryCode.toUpperCase()}',
        dotenv.get('UNSPLASH_API_ACCESS_KEY')
      );
      final palette = await findTextPalette(image.results.first.urls.thumb);
      final updatedPlace = _updatePicture(
        userPlace,
        image.results.first.urls.regular,
        image.results.first.user.name,
        'https://unsplash.com/@${image.results.first.user.username}',
        palette
      );
      await _savedPlaceDao.updatePlace(updatedPlace);
      Log().w(_logTag, 'updatePicture');
    }catch(e){
      return ImageError();
    }

    return Success();

  }

  @override
  Future<PlaceSetupResponse> retryFromImage() async {

    // step 0 - check if place is changed
    final userPlace = await _savedPlaceDao.getUserPlace();
    if(userPlace == null) { return FindPlaceError(); }

    try{
      final userPlace = await _savedPlaceDao.getUserPlace();
      if(userPlace == null) { return ImageError(); }
      final image = await _unsplashClient.getPicture(
        '${userPlace.placeName} city, ${userPlace.placeCountryCode.toUpperCase()}',
        dotenv.get('UNSPLASH_API_ACCESS_KEY')
      );
      final palette = await findTextPalette(image.results.first.urls.thumb);
      final updatedPlace = _updatePicture(
        userPlace,
        image.results.first.urls.regular,
        image.results.first.user.name,
        'https://unsplash.com/@${image.results.first.user.username}',
        palette
      );
      await _savedPlaceDao.updatePlace(updatedPlace);
      Log().w(_logTag, 'updatePicture');
    }catch(e){
      return ImageError();
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
        Log().w(_logTag, 'userPlaceLive - place: $place , weather: $weather');
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

  SavedPlaceDto _updatePicture(SavedPlaceDto dto, String pictureUrl, String pictureAuthor, String pictureUsername, PlacePicturePalette palette){
    return SavedPlaceDto(
      dto.id,
      dto.placeName,
      dto.placeTimezone,
      dto.placeCountryCode,
      pictureUrl,
      pictureAuthor,
      'https://unsplash.com/@$pictureUsername',
      palette,
      dto.latitude,
      dto.longitude,
      false,
      dto.addTime
    );
  }

  double _calculateDistance(lat1, lon1, lat2, lon2){
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat2 - lat1) * p)/2 + c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p))/2;
    return 12742 * asin(sqrt(a));
  }

  @override
  void dispose() {}

}