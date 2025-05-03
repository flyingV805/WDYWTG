part of 'find_bloc.dart';

class FindState extends Equatable {

  const FindState._({
    this.showList = false,
    this.suggestions,
    this.error,
    this.searching = false
  });

  const FindState.empty() : this._();

  const FindState.successfullyAdded() : this._(
    showList: false,
    suggestions: null,
    error: null,
  );

  final bool showList;
  final List<PlaceSuggestion>? suggestions;
  final AddingError? error;
  final bool searching;

  @override
  List<Object> get props => [showList, suggestions ?? [], error ?? Empty, searching];

  FindState copyWith({
    bool? showList,
    List<PlaceSuggestion>? suggestions,
    AddingError? error,
    bool? searching,
  }) {
    return FindState._(
      showList: showList ?? this.showList,
      suggestions: suggestions ?? this.suggestions,
      error: error ?? this.error,
      searching: searching ?? this.searching,
    );
  }

}

sealed class AddingError {}

final class Empty extends AddingError {}

final class AlreadyExistsError extends AddingError {

  final PlaceSuggestion place;

  AlreadyExistsError({required this.place});

}

final class GetWeatherError extends AddingError {

  final PlaceSuggestion place;

  GetWeatherError({required this.place});

}

final class GetImageError extends AddingError {

  final PlaceSuggestion place;

  GetImageError({required this.place});

}

final class GetAdvicesError extends AddingError {

  final PlaceSuggestion place;

  GetAdvicesError({required this.place});

}