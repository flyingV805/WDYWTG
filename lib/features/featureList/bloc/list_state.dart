part of 'list_bloc.dart';

final class ListState extends Equatable {

  const ListState._({
    this.places,
  });

  const ListState.empty() : this._();

  final List<PlaceProfile>? places;

  @override
  List<Object?> get props => [places];

  ListState copyWith({
    List<PlaceProfile>? places
  }) {
    return ListState._(
      places: places ?? this.places,
    );
  }


}
