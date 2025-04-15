import 'package:wdywtg/core/repositories/abstract/repository.dart';

import '../model/place_suggestion.dart';

abstract class GeocodingRepository extends Repository {

  Future<List<PlaceSuggestion>> findSuggestions(String input);

}