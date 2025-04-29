import 'package:wdywtg/core/repositories/abstract/repository.dart';
import 'package:wdywtg/features/featureFind/model/place_suggestion.dart';

import '../model/add_result.dart';

abstract class AddPlaceRepository extends Repository {

  Future<AddResult> addSavedPlace(PlaceSuggestion suggestion);
  Future<AddResult> retryFromWeather(PlaceSuggestion suggestion);
  Future<AddResult> retryFromImage(PlaceSuggestion suggestion);
  Future<AddResult> retryFromAdvices(PlaceSuggestion suggestion);

}