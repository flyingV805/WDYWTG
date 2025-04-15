import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wdywtg/features/featureList/model/place_profile.dart';

import '../../../commonModel/place_weather.dart';
import '../model/place.dart';
import '../model/place_advice.dart';

part 'list_event.dart';
part 'list_state.dart';

class ListBloc extends Bloc<ListEvent, ListState> {

  ListBloc() : super(ListState.empty()) {
    on<Initialize>(_startRoutine);
  }

  Future<void> _startRoutine(Initialize event, Emitter<ListState> emit) async {

    emit.call(state.copyWith(places: [
      PlaceProfile(
        place: Place.examplePlace(),
        weather: PlaceWeather.exampleWeather(),
        advices: [PlaceAdvice.exampleAdvice(), PlaceAdvice.exampleAdvice()]
      ),
      PlaceProfile(
          place: Place.examplePlace(),
          weather: PlaceWeather.exampleWeather(),
          advices: [PlaceAdvice.exampleAdvice(), PlaceAdvice.exampleAdvice()]
      )
    ]));

  }

}
