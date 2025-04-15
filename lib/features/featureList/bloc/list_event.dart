part of 'list_bloc.dart';

sealed class ListEvent {
  const ListEvent();
}

final class Initialize extends ListEvent {}