import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wdywtg/core/log/loger.dart';

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

    UserPosition.determinePosition()
        .then((value){

        })
        .onError((error, stackTrace){

        });

    Log().w(_logTag, '_checkLocation - Intial event');

  }

  Future<void> _onSearchUpdate(
    UpdateSearch event,
    Emitter<MainState> emit
  ) async {

  }


}