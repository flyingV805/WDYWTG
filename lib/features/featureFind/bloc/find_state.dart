part of 'find_bloc.dart';

class FindState extends Equatable {

  const FindState._({
    this.showList = false,
    this.suggestions,
  });

  const FindState.empty() : this._();

  final bool showList;
  final List<PlaceSuggestion>? suggestions;


  @override
  List<Object> get props => [showList, suggestions ?? []];

  FindState copyWith({
    bool? showList,
    List<PlaceSuggestion>? suggestions
  }) {
    return FindState._(
      showList: showList ?? this.showList,
      suggestions: suggestions ?? this.suggestions
    );
  }

}
