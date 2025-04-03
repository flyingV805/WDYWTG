import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wdywtg/core/log/loger.dart';
import 'package:wdywtg/core/openMeteo/open_meteo_client.dart';

import '../../../core/location/user_position.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {

  static final String _logTag = 'MainBloc';

  MainBloc(): super(const MainState.empty()){
    Log().w(_logTag, 'super');
    on<Initialize>(_checkLocation);
    on<UpdateSearch>(_onSearchUpdate);
  }

  Future<void> _checkLocation(
    Initialize event,
    Emitter<MainState> emit
  ) async {

    final dio = Dio(); // Provide a dio instance
    final client = OpenMeteoClient(dio);

    client.getForecast(54.875, 69.125).then((response){
      Log().w(_logTag, '_forecast - ${jsonEncode(response)}');
    }).onError((error, trace){
      Log().w(_logTag, '_forecast error - $error');
    });

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