import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wdywtg/core/location/user_position.dart';
import 'package:wdywtg/core/log/loger.dart';

import '../model/place_weather.dart';
import '../repository/user/user_repository.dart';
import '../repository/weather/weather_repository.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {

  final WeatherRepository _weatherRepository;
  final UserRepository _userRepository;
  static final String _logTag = 'MainBloc';

  MainBloc({
    required WeatherRepository weatherRepository,
    required UserRepository userRepository,
  }): _weatherRepository = weatherRepository,
      _userRepository = userRepository,
    super(const MainState.empty()){
      Log().w(_logTag, 'super');
      on<Initialize>(_startRoutine);
      on<UseCurrentLocation>(_useApprovedLocation);
      on<CancelCurrentLocationRequest>(_userCanceledLocation);
      on<UpdateSearch>(_onSearchUpdate);
    }

  Future<void> _startRoutine(
    Initialize event,
    Emitter<MainState> emit
  ) async {

    final showUserLocationDialog = await _userRepository.showUserLocation();
    if(showUserLocationDialog){
      emit.call(MainState.displayLocation());
      emit.call(MainState.updateUserWeather(PlaceWeather.exampleWeather()));
    }else{
      var shouldAsk = await _userRepository.needAskForLocation().whenComplete((){});
      if(shouldAsk){ emit.call(MainState.requestLocation()); }
    }

  }

  Future<void> _useApprovedLocation(
    UseCurrentLocation event,
    Emitter<MainState> emit
  ) async {
    _userRepository.setNeedAskForLocation(false);
    _userRepository.setShowUserLocation(true);

    //state;
    emit.call(MainState.displayLocation());
    UserPosition.determinePosition();

  }

  Future<void> _userCanceledLocation(
    CancelCurrentLocationRequest event,
    Emitter<MainState> emit
  ) async {

    _userRepository.setNeedAskForLocation(false);
    _userRepository.setShowUserLocation(false);
  }

  Future<void> _checkLocation(
    Initialize event,
    Emitter<MainState> emit
  ) async {

    //final weather = await _weatherRepository.getWeather();

    //Log().w(_logTag, 'weather - $weather');

    /*UserPosition.determinePosition()
      .then((value){

      })
      .onError((error, stackTrace){

      });*/

    await Future.delayed(Duration(milliseconds: 700)).whenComplete(() => emit.call(MainState.userLocated()) );

    Log().w(_logTag, '_checkLocation - Intial event');

  }

  Future<void> _onSearchUpdate(
    UpdateSearch event,
    Emitter<MainState> emit
  ) async {

  }


}