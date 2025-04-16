part of 'list_bloc.dart';

final class ListState extends Equatable {

  const ListState._({
    this.places,
    this.noSavedPlaces = false
  });

  const ListState.empty() : this._();

  final List<PlaceProfile>? places;
  final bool noSavedPlaces;

  @override
  List<Object?> get props => [places, noSavedPlaces];

  ListState copyWith({
    List<PlaceProfile>? places,
    bool? noSavedPlaces
  }) {
    return ListState._(
      places: places ?? this.places,
      noSavedPlaces: noSavedPlaces ?? this.noSavedPlaces
    );
  }


}
