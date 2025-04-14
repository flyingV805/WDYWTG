part of 'main_bloc.dart';

sealed class MainEvent {
  const MainEvent();
}

final class Initialize extends MainEvent {}

final class UseUserCurrentLocation extends MainEvent {}

final class CancelCurrentLocationRequest extends MainEvent {}

final class UpdateSearch extends MainEvent {

  final String searchable;

  UpdateSearch({required this.searchable});

}

final class SearchUpdated extends MainEvent {

  final List<PlaceSuggestion> suggestions;

  SearchUpdated({required this.suggestions});

}