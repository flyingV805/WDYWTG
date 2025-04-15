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

    if(showUserLocation){
      emit.call(state.copyWith(displayUserLocation: true));
    }else{
      var shouldAsk = await _userRepository.needAskForLocation();
      Log().w(_logTag, 'shouldAsk - $shouldAsk');
      if(shouldAsk){ emit.call(state.copyWith(askForLocation: true)); }
    }

    await Future.delayed(Duration(seconds: 1));
    emit.call(state.copyWith(
      locationFound: true,
      userPlace: UserPlace(placeName: 'Florida', placeCountryCode: 'US', placePictureUrl: 'placePictureUrl'),
      weather: PlaceWeather.exampleWeather()
    ));

  }

  Future<void> _locationApproved(
    UserApprovedLocation event,
    Emitter<UserLocationState> emit
  ) async {

    _userRepository.setNeedAskForLocation(false);
    _userRepository.setShowUserLocation(true);

    //state;
    emit.call(state.copyWith(displayUserLocation: true));
    UserPosition.determinePosition();

  }

  Future<void> _locationDeclined(
    UserDeclinedLocation event,
    Emitter<UserLocationState> emit
  ) async {

    _userRepository.setNeedAskForLocation(false);
    _userRepository.setShowUserLocation(false);

  }


}