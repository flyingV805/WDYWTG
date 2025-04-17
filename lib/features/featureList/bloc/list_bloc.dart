import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wdywtg/features/featureList/model/place_profile.dart';
import 'package:wdywtg/features/featureList/repository/saved_places_repository.dart';

part 'list_event.dart';
part 'list_state.dart';

class ListBloc extends Bloc<ListEvent, ListState> {

  final SavedPlacesRepository _placesRepository;

  ListBloc({
    required SavedPlacesRepository placesRepository,
  }):
    _placesRepository = placesRepository,
    super(ListState.empty()) {
      on<Initialize>(_startRoutine);
      on<UpdateState>(_updateState);
      _placesRepository.placesStream().listen((places) {
        add(UpdateState(places: places));
      });
    }

  Future<void> _startRoutine(Initialize event, Emitter<ListState> emit) async {

    Future.delayed(Duration(seconds: 5)).then((_){
      _placesRepository.testInsert();
    });


/*
    emit.call(state.copyWith(
      noSavedPlaces: true, 
      /*places: [
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
    ]*/));*/

  }

  Future<void> _updateState(UpdateState event, Emitter<ListState> emit) async {
    emit.call(state.copyWith(
      noSavedPlaces: event.places.isEmpty,
      places: event.places
    ));
  }

}
