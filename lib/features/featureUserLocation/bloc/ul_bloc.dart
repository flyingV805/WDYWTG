import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wdywtg/features/featureUserLocation/bloc/ul_event.dart';
import 'package:wdywtg/features/featureUserLocation/bloc/ul_state.dart';
import 'package:wdywtg/features/featureUserLocation/model/place_setup_response.dart';

import '../../../core/location/user_position.dart';
import '../../../core/log/loger.dart';
import '../repository/user_repository.dart';

class UserLocationBloc extends Bloc<UserLocationEvent, UserLocationState>{

  static final String _logTag = 'UserLocationBloc';

  final UserRepository _userRepository;

  UserLocationBloc({
    required UserRepository userRepository,
  }): _userRepository = userRepository,
  super(UserLocationState.empty()){
    on<Initialize>(_startRoutine);
    on<UpdatePlaceData>(_updatePlaceInfo);
    on<UserApprovedLocation>(_locationApproved);
    on<UserDeclinedLocation>(_locationDeclined);

    on<RetryLocation>(_retryLocation);
    on<RetryWeather>(_retryWeather);
    on<RetryImage>(_retryImage);
    on<SkipImage>(_skipImage);
    on<RetryGeocode>(_retryGeocode);
    on<SkipGeocode>(_skipGeocode);
    on<DisableFeature>(_disableFeature);

    userRepository.userPlaceLive().listen((userPlace){
      add(UpdatePlaceData(place: userPlace));
    });

  }

  Future<void> _startRoutine(Initialize event, Emitter<UserLocationState> emit) async {

    Log().w(_logTag, '_startRoutine');

    final showUserLocation = await _userRepository.showUserLocation();

    // user approved using location last time
    if(showUserLocation){
      emit.call(state.copyWith(displayUserLocation: true));
      _findUserLocation(emit);
    }else{
      var shouldAsk = await _userRepository.needAskForLocation();
      Log().w(_logTag, 'shouldAsk - $shouldAsk');
      if(shouldAsk){ emit.call(state.copyWith(askForLocation: true)); }
    }

  }

  Future<void> _locationApproved(UserApprovedLocation event, Emitter<UserLocationState> emit) async {
    _userRepository.setNeedAskForLocation(false);
    _userRepository.setShowUserLocation(true);
    emit.call(state.copyWith(askForLocation: false, displayUserLocation: true));
    _findUserLocation(emit);
  }

  Future<void> _locationDeclined(UserDeclinedLocation event, Emitter<UserLocationState> emit) async {
    _userRepository.setNeedAskForLocation(false);
    _userRepository.setShowUserLocation(false);
    emit.call(state.copyWith(askForLocation: false));
  }

  Future<void> _updatePlaceInfo(UpdatePlaceData event, Emitter<UserLocationState> emit) async {
    final place = event.place?.toPlace();
    emit.call(state.copyWith(
      askForLocation: false,
      locationFound: place != null,
      userPlace: place,
      weather: event.place?.weather
    ));

  }

  Future<void> _retryLocation(RetryLocation event, Emitter<UserLocationState> emit) async {

  }

  Future<void> _retryWeather(RetryWeather event, Emitter<UserLocationState> emit) async {

  }

  Future<void> _retryImage(RetryImage event, Emitter<UserLocationState> emit) async {

  }

  Future<void> _skipImage(SkipImage event, Emitter<UserLocationState> emit) async {

  }

  Future<void> _retryGeocode(RetryGeocode event, Emitter<UserLocationState> emit) async {

  }

  Future<void> _skipGeocode(SkipGeocode event, Emitter<UserLocationState> emit) async {

  }

  Future<void> _disableFeature(DisableFeature event, Emitter<UserLocationState> emit) async {

  }

  void _findUserLocation(Emitter<UserLocationState> emit){
    Log().w(_logTag, '_findUserLocation');
    UserPosition.determinePosition().then((result){
      Log().w(_logTag, 'determinePosition result - $result');
      switch(result){
        case PositionFound():
          updatePlaceParameters(result.latitude, result.longitude, emit);
          break;
        case PermissionError():
          emit(state.copyWith(error: PermissionDeclinedError(isForever: result.isForever)));
          break;
        case ServiceError():
          emit(state.copyWith(error: ServiceDisabledError()));
          break;
        case PositionError():
          emit(state.copyWith(error: FetchLocationError()));
          break;
      }
    });
  }

  void updatePlaceParameters(double latitude, double longitude, Emitter<UserLocationState> emit) async {
    Log().w(_logTag, 'updatePlaceParameters - $latitude $longitude');
    final result = await _userRepository.updateUserPlace(latitude, longitude);
    switch(result){
      case Success(): break;
      case FindPlaceError(): emit(state.copyWith(error: GeocodeError())); break;
      case WeatherError(): emit(state.copyWith(error: GetWeatherError())); break;
      case ImageError(): emit(state.copyWith(error: GetImageError())); break;
    }

  }

}