import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wdywtg/commonModel/place_weather.dart';
import 'package:wdywtg/features/featureUserLocation/bloc/ul_event.dart';
import 'package:wdywtg/features/featureUserLocation/bloc/ul_state.dart';
import 'package:wdywtg/features/featureUserLocation/model/user_place.dart';

import '../../../core/location/user_position.dart';
import '../../../core/log/loger.dart';
import '../../../core/repositories/weather/weather_repository.dart';
import '../repository/user_repository.dart';

class UserLocationBloc extends Bloc<UserLocationEvent, UserLocationState>{

  static final String _logTag = 'UserLocationBloc';

  final WeatherRepository _weatherRepository;
  final UserRepository _userRepository;

  UserLocationBloc({
    required WeatherRepository weatherRepository,
    required UserRepository userRepository,
  }):  _weatherRepository = weatherRepository,
       _userRepository = userRepository,
  super(UserLocationState.empty()){
    on<Initialize>(_startRoutine);
    on<UserApprovedLocation>(_locationApproved);
    on<UserDeclinedLocation>(_locationDeclined);
  }

  Future<void> _startRoutine(
    Initialize event,
    Emitter<UserLocationState> emit
  ) async {

    Log().w(_logTag, '_startRoutine');

    final showUserLocation = await _userRepository.showUserLocation();

    // user approved using location last time
    if(showUserLocation){
      emit.call(state.copyWith(displayUserLocation: true));

      // check if saved location in repository
      final lastLocation = await _userRepository.lastUserPlace();
      if(lastLocation != null){
        // get from cache, and update if location changed
        emit.call(state.copyWith(
          locationFound: true,
          userPlace: lastLocation,
          weather: PlaceWeather.exampleWeather()
        ));
      }else{
        //cache is empty, time to find and save to cache
        Log().w(_logTag, 'lastLocation - null');
        _findUserLocation();
      }

      await Future.delayed(Duration(seconds: 1));
      emit.call(state.copyWith(
        locationFound: true,
        userPlace: UserPlace(placeName: 'Florida', placeCountryCode: 'US', placePictureUrl: 'placePictureUrl', latitude: 0.0, longitude: 0.0),
        weather: PlaceWeather.exampleWeather()
      ));

    }else{
      var shouldAsk = await _userRepository.needAskForLocation();
      Log().w(_logTag, 'shouldAsk - $shouldAsk');
      if(shouldAsk){ emit.call(state.copyWith(askForLocation: true)); }
    }

  }

  Future<void> _locationApproved(
    UserApprovedLocation event,
    Emitter<UserLocationState> emit
  ) async {

    _userRepository.setNeedAskForLocation(false);
    _userRepository.setShowUserLocation(true);

    emit.call(state.copyWith(askForLocation: false, displayUserLocation: true));

    await Future.delayed(Duration(seconds: 1));
    emit.call(state.copyWith(
      locationFound: true,
      userPlace: UserPlace(placeName: 'Florida', placeCountryCode: 'US', placePictureUrl: 'placePictureUrl', latitude: 0.0, longitude: 0.0),
      weather: PlaceWeather.exampleWeather()
    ));

  }

  Future<void> _locationDeclined(
    UserDeclinedLocation event,
    Emitter<UserLocationState> emit
  ) async {

    _userRepository.setNeedAskForLocation(false);
    _userRepository.setShowUserLocation(false);
    emit.call(state.copyWith(askForLocation: false));

  }

  void _findUserLocation(){
    Log().w(_logTag, '_findUserLocation');
    UserPosition.determinePosition().then((result){
      Log().w(_logTag, 'determinePosition result - $result');
      switch(result){
        case PositionFound():
          updatePlaceParameters(result.latitude, result.longitude);
        case PermissionError():
          // TODO: Handle this case.
          throw UnimplementedError();
        case ServiceError():
          // TODO: Handle this case.
          throw UnimplementedError();
        case PositionError():
          // TODO: Handle this case.
          throw UnimplementedError();
      }
    });
  }

  void updatePlaceParameters(double latitude, double longitude){
    Log().w(_logTag, 'updatePlaceParameters - $latitude $longitude');

  }

}