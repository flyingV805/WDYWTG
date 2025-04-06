import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wdywtg/core/log/loger.dart';

import '../repository/weather/weather_repository.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {

  final WeatherRepository _weatherRepository;
  static final String _logTag = 'MainBloc';

  MainBloc({
    required WeatherRepository weatherRepository
  }): _weatherRepository = weatherRepository,
    super(const MainState.empty()){
      Log().w(_logTag, 'super');
      on<Initialize>(_startRoutine);
      on<UpdateSearch>(_onSearchUpdate);
    }

  Future<void> _startRoutine(
    Initialize event,
    Emitter<MainState> emit
  ) async {

    emit.call(MainState.requestLocation());

    await Future.delayed(Duration(milliseconds: 1700)).whenComplete(() {
      Log().w(_logTag, '_displayLocation - Intial event');
      emit.call(MainState.displayLocation());
    } );

    //emit.call(MainState.userLocated());
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