part of 'find_bloc.dart';

class FindState extends Equatable {

  const FindState._({
    this.showList = false,
    this.suggestions,
    this.error,
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

  @override
  List<Object> get props => [showList, suggestions ?? [], error.toString()];

  FindState copyWith({
    bool? showList,
    List<PlaceSuggestion>? suggestions,
    AddingError? error,
  }) {
    return FindState._(
      showList: showList ?? this.showList,
      suggestions: suggestions ?? this.suggestions,
      error: error ?? this.error,
    );
  }

}

sealed class AddingError {}

class AlreadyExistsError extends AddingError {

  final PlaceSuggestion place;

  AlreadyExistsError({required this.place});

}

class GetWeatherError extends AddingError {

  final PlaceSuggestion place;

  GetWeatherError({required this.place});

}

class GetImageError extends AddingError {

  final PlaceSuggestion place;

  GetImageError({required this.place});

}

class GetAdvicesError extends AddingError {

  final PlaceSuggestion place;

  GetAdvicesError({required this.place});

}