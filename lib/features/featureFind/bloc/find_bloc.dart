import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:wdywtg/features/featureFind/model/add_result.dart';
import 'package:wdywtg/features/featureFind/repository/add_place_repository.dart';

import '../../../core/log/loger.dart';
import '../model/place_suggestion.dart';
import '../repository/geocoding_repository.dart';

part 'find_event.dart';
part 'find_state.dart';

class FindBloc extends Bloc<FindEvent, FindState> {

  final GeocodingRepository _geocodingRepository;
  final AddPlaceRepository _addRepository;
  final _searchController = StreamController<String>.broadcast();
  final FocusNode _focusNode;
  final TextEditingController _fieldController;

  static final String _logTag = 'FindBloc';

  FindBloc({
    required GeocodingRepository geocodingRepository,
    required AddPlaceRepository addRepository,
    required FocusNode focusNode,
    required TextEditingController fieldController
  }) :
    _geocodingRepository = geocodingRepository,
    _addRepository = addRepository,
    _focusNode = focusNode,
    _fieldController = fieldController,
    super(FindState.empty()) {

      on<FocusUpdated>(_focusUpdated);
      on<UpdateSearch>(_onSearchUpdate);
      on<SearchUpdated>(_updateSuggestions);
      on<AddPlace>(_addPlace);

      // errors interactions
      on<RetryWeather>(_retryWeather);
      on<RetryImage>(_retryImage);
      on<SkipImage>(_skipImage);
      on<RetryAdvices>(_retryAdvices);
      on<SkipAdvices>(_skipAdvices);
      on<CancelError>(_cancelError);

      _focusNode.addListener(() {
        Log().d(_logTag, '_focusNode - ${_focusNode.hasFocus}');
        add(FocusUpdated(isFocused: _focusNode.hasFocus));
      });

      _searchController.stream
        .debounceTime(const Duration(milliseconds: 500))
        .distinct()
        .switchMap((query) => _performSearch(query).asStream())
        .listen((found) {
          Log().d(_logTag, '_searching - ${found.join()}');
          add(SearchUpdated(suggestions: found));
        });

  }

  Future<void> _focusUpdated(FocusUpdated event, Emitter<FindState> emit) async {
    Log().d(_logTag, 'showList - ${event.isFocused}');
    emit(state.copyWith(showList: event.isFocused));
  }

  Future<void> _onSearchUpdate(UpdateSearch event, Emitter<FindState> emit) async {
    Log().d(_logTag, '_onSearchUpdate');
    final searchable = event.searchable.trim();
    if(searchable.isEmpty){ return; }
    if(searchable.length < 3){ return; }
    emit(state.copyWith(searching: true));
    _searchController.sink.add(searchable);
  }

  Future _updateSuggestions(SearchUpdated event, Emitter<FindState> emit) async {
    Log().d(_logTag, '_updateSuggestions');
    emit.call(state.copyWith(suggestions: event.suggestions, searching: false));
  }

  Future _addPlace(AddPlace event, Emitter<FindState> emit) async {

    _focusNode.unfocus();
    _fieldController.clear();
    final result = await _addRepository.addSavedPlace(event.placeToAdd);

    Log().d(_logTag, 'adding result - $result');
    _handleResult(emit, event.placeToAdd, result);

  }

  Future _retryWeather(RetryWeather event, Emitter<FindState> emit) async {
    Log().d(_logTag, '_retryWeather');
    emit(state.copyWith(error: Empty()));
    final result = await _addRepository.retryFromWeather(event.placeToAdd);
    Log().d(_logTag, '_retryWeather result - $result');
    _handleResult(emit, event.placeToAdd, result);
  }

  Future _retryImage(RetryImage event, Emitter<FindState> emit) async {
    final result = await _addRepository.retryFromImage(event.placeToAdd);
    _handleResult(emit, event.placeToAdd, result);
  }

  Future _skipImage(SkipImage event, Emitter<FindState> emit) async {
    add(RetryAdvices(placeToAdd: event.placeToAdd));
  }

  Future _retryAdvices(RetryAdvices event, Emitter<FindState> emit) async {
    final result = await _addRepository.retryFromAdvices(event.placeToAdd);
    _handleResult(emit, event.placeToAdd, result);
  }

  Future _skipAdvices(SkipAdvices event, Emitter<FindState> emit) async {
    emit(FindState.successfullyAdded());
  }

  Future _cancelError(CancelError event, Emitter<FindState> emit) async {
    _focusNode.unfocus();
    _fieldController.clear();
    emit(FindState.successfullyAdded());
  }

  void _handleResult(Emitter<FindState> emit, PlaceSuggestion place, AddResult result){
    Log().d(_logTag, '_handleResult - $result');
    switch(result){
      case Success():
        emit(FindState.successfullyAdded());
        break;
      case AlreadyAddedError():
        emit(state.copyWith(error: AlreadyExistsError(place: place)));
        break;
      case WeatherError():
        emit(state.copyWith(error: GetWeatherError(place: place)));
        break;
      case ImageError():
        emit(state.copyWith(error: GetImageError(place: place)));
        break;
      case AdvicesError():
        emit(state.copyWith(error: GetAdvicesError(place: place)));
        break;
    }
  }

  Future<List<PlaceSuggestion>> _performSearch(String searchable) async {
    final suggestions = _geocodingRepository.findSuggestions(searchable);
    return suggestions;
  }

}
