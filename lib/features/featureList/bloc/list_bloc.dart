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
      on<UpdateState>(_updateState);
      on<RemovePlace>(_removePlace);
      _placesRepository.placesStream().listen((places) {
        add(UpdateState(places: places));
      });
    }

  Future<void> _removePlace(RemovePlace event, Emitter<ListState> emit) async {
    await _placesRepository.removePlace(event.place.place);
  }

  Future<void> _updateState(UpdateState event, Emitter<ListState> emit) async {
    emit.call(state.copyWith(
      noSavedPlaces: event.places.isEmpty,
      places: event.places
    ));
  }

}
