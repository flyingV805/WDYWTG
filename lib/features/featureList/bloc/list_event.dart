part of 'list_bloc.dart';

sealed class ListEvent {
  const ListEvent();
}

final class UpdateState extends ListEvent {

  final List<PlaceProfile> places;

  UpdateState({required this.places});

}


final class RemovePlace extends ListEvent {

  final PlaceProfile place;

  RemovePlace({required this.place});

}