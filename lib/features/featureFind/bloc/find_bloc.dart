import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';
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

  static final String _logTag = 'MainBloc';

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
      on<Initialize>(_startRoutine);
      on<FocusUpdated>(_focusUpdated);
      on<UpdateSearch>(_onSearchUpdate);
      on<SearchUpdated>(_updateSuggestions);
      on<AddPlace>(_addPlace);

      _focusNode.addListener(() {
        Log().w(_logTag, '_focusNode - ${_focusNode.hasFocus}');
        add(FocusUpdated(isFocused: _focusNode.hasFocus));
      });

      _searchController.stream
        .debounceTime(const Duration(milliseconds: 500))
        .distinct()
        .switchMap((query) => _performSearch(query).asStream())
        .listen((found) {
          Log().w(_logTag, '_searching - ${found.join()}');
          add(SearchUpdated(suggestions: found));
        });

  }

  Future<void> _startRoutine(Initialize event, Emitter<FindState> emit) async {
    // searching setup - debounce
    /*_searchController.stream
      .debounceTime(const Duration(milliseconds: 500))
      .distinct()
      .switchMap((query) => _performSearch(query).asStream())
      .listen((found) {
        Log().w(_logTag, '_searching - ${found.join()}');
        add(SearchUpdated(suggestions: found));
      }
    );*/

    Log().w(_logTag, '_startRoutine - START COMPLETED');
  }

  Future<void> _focusUpdated(FocusUpdated event, Emitter<FindState> emit) async {
    Log().w(_logTag, 'showList - ${event.isFocused}');
    emit(state.copyWith(showList: event.isFocused));
  }

  Future<void> _onSearchUpdate(UpdateSearch event, Emitter<FindState> emit) async {
    Log().w(_logTag, '_onSearchUpdate');
    _searchController.sink.add(event.searchable);
  }

  Future _updateSuggestions(SearchUpdated event, Emitter<FindState> emit) async {
    Log().w(_logTag, '_updateSuggestions');
    emit.call(state.copyWith(suggestions: event.suggestions));
  }

  Future _addPlace(AddPlace event, Emitter<FindState> emit) async {
    Log().w(_logTag, '_updateSuggestions');
    _focusNode.unfocus();
    _fieldController.clear();
    final result = await _addRepository.addSavedPlace(event.placeToAdd);
    emit(state.copyWith(suggestions: []));
    //emit.call(state.copyWith(suggestions: event.suggestions));
  }

  Future<List<PlaceSuggestion>> _performSearch(String searchable) async {
    if(searchable.isEmpty){ return []; }
    if(searchable.length < 3){ return []; }
    final suggestions = _geocodingRepository.findSuggestions(searchable);
    return suggestions;
  }

}
