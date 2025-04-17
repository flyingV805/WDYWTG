part of 'list_bloc.dart';

sealed class ListEvent {
  const ListEvent();
}

final class Initialize extends ListEvent {}

final class UpdateState extends ListEvent {

  final List<PlaceProfile> places;

  UpdateState({required this.places});

}