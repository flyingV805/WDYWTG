import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:wdywtg/core/location/user_position.dart';
import 'package:wdywtg/core/log/loger.dart';
import 'package:wdywtg/features/featureMain/model/place_profile.dart';
import 'package:wdywtg/features/featureMain/model/user_place.dart';
import 'package:wdywtg/uiKit/aiAdvice/ai_advice.dart';

import '../model/place.dart';
import '../model/place_advice.dart';
import '../model/place_suggestion.dart';
import '../model/place_weather.dart';
import '../repository/user/user_repository.dart';
import '../repository/weather/weather_repository.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {

  final WeatherRepository _weatherRepository;
  final UserRepository _userRepository;
  final _searchController = StreamController<String>.broadcast();

  static final String _logTag = 'MainBloc';

  MainBloc({
    required WeatherRepository weatherRepository,
    required UserRepository userRepository,
  }): _weatherRepository = weatherRepository,
      _userRepository = userRepository,
    super(const MainState.empty()){
      Log().w(_logTag, 'super');
      on<Initialize>(_startRoutine);
      on<UseUserCurrentLocation>(_userApprovedLocation);
      on<CancelCurrentLocationRequest>(_userCanceledLocation);
      on<UpdateSearch>(_onSearchUpdate);
      on<SearchUpdated>(_updateSuggestions);
    }

  // init all that should be initiated
  Future<void> _startRoutine(
    Initialize event,
    Emitter<MainState> emit
  ) async {

    Log().w(_logTag, '_startRoutine');

    final showUserLocationDialog = await _userRepository.showUserLocation();

    if(showUserLocationDialog){
      emit.call(state.copyWith(displayUserLocation: true));
    }else{
      var shouldAsk = await _userRepository.needAskForLocation();
      Log().w(_logTag, 'shouldAsk - $shouldAsk');
      if(shouldAsk){ emit.call(state.copyWith(askForLocation: true)); }
    }

    Log().w(_logTag, 'pre-call');
    emit.call(state.copyWith(savedPlaces: [
      PlaceProfile(
        place: Place.examplePlace(),
        weather: PlaceWeather.exampleWeather(),
        advices: [PlaceAdvice.exampleAdvice(), PlaceAdvice.exampleAdvice()]
      )
    ]));
    Log().w(_logTag, 'post-call');

    // searching setup - debounce
    _searchController.stream
      .debounceTime(const Duration(milliseconds: 500))
      .distinct()
      .switchMap((query) => _performSearch(query).asStream())
      .listen((found) {
        Log().w(_logTag, '_searching - ${found.join()}');
        add(SearchUpdated(suggestions: found));
      });


    Log().w(_logTag, '_startRoutine - START COMPLETED');

  }

  Future<void> _userApprovedLocation(
    UseUserCurrentLocation event,
    Emitter<MainState> emit
  ) async {
    Log().w(_logTag, '_userApprovedLocation');

    _userRepository.setNeedAskForLocation(false);
    _userRepository.setShowUserLocation(true);

    //state;
    emit.call(state.copyWith(displayUserLocation: true));
    UserPosition.determinePosition();

  }

  Future<void> _userCanceledLocation(
    CancelCurrentLocationRequest event,
    Emitter<MainState> emit
  ) async {
    Log().w(_logTag, '_userCanceledLocation');

    _userRepository.setNeedAskForLocation(false);
    _userRepository.setShowUserLocation(false);
  }

  Future<void> _checkLocation(
    Initialize event,
    Emitter<MainState> emit
  ) async {
    Log().w(_logTag, '_checkLocation');
    //final weather = await _weatherRepository.getWeather();

    //Log().w(_logTag, 'weather - $weather');

    /*UserPosition.determinePosition()
      .then((value){

      })
      .onError((error, stackTrace){

      });*/

    //await Future.delayed(Duration(milliseconds: 700)).whenComplete(() => emit.call(MainState.userLocated()) );

    Log().w(_logTag, '_checkLocation - Intial event');

  }

  Future<void> _onSearchUpdate(
    UpdateSearch event,
    Emitter<MainState> emit
  ) async {
    Log().w(_logTag, '_onSearchUpdate');
    _searchController.sink.add(event.searchable);
  }

  Future _updateSuggestions(
    SearchUpdated event,
    Emitter<MainState> emit
  ) async {
    Log().w(_logTag, '_updateSuggestions');
    emit.call(state.copyWith(suggestions: event.suggestions));
  }

  Future<List<PlaceSuggestion>> _performSearch(String searchable) async {
    if(searchable.isEmpty){ return []; }
    await Future.delayed(Duration(milliseconds: 500));
    return [
      PlaceSuggestion.exampleSuggestion(),
      PlaceSuggestion.exampleSuggestion(),
      PlaceSuggestion.exampleSuggestion(),
    ];
  }

}