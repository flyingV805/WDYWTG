part of 'main_bloc.dart';

sealed class MainEvent {
  const MainEvent();
}

final class Initialize extends MainEvent {}

final class UpdateSearch extends MainEvent {

  final String searchable;

  UpdateSearch({required this.searchable});

}