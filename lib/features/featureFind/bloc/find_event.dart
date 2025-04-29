part of 'find_bloc.dart';

sealed class FindEvent {
  const FindEvent();
}

final class FocusUpdated extends FindEvent {

  final bool isFocused;

  FocusUpdated({required this.isFocused});

}

final class UpdateSearch extends FindEvent {

  final String searchable;

  UpdateSearch({required this.searchable});

}

final class SearchUpdated extends FindEvent {

  final List<PlaceSuggestion> suggestions;

  SearchUpdated({required this.suggestions});

}

final class AddPlace extends FindEvent {

  final PlaceSuggestion placeToAdd;

  AddPlace({required this.placeToAdd});

}

final class RetryWeather extends FindEvent {

  final PlaceSuggestion placeToAdd;

  RetryWeather({required this.placeToAdd});

}

final class RetryImage extends FindEvent {

  final PlaceSuggestion placeToAdd;

  RetryImage({required this.placeToAdd});

}

final class RetryAdvices extends FindEvent {

  final PlaceSuggestion placeToAdd;

  RetryAdvices({required this.placeToAdd});

}


final class CancelError extends FindEvent {

  final PlaceSuggestion placeToAdd;

  CancelError({required this.placeToAdd});

}