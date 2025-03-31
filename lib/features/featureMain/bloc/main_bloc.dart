import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {

  MainBloc(): super(const MainState.empty()){
    on<UpdateSearch>(_onSearchUpdate);
  }


  Future<void> _onSearchUpdate(
    UpdateSearch event,
    Emitter<MainState> emit
  ) async {

  }


}