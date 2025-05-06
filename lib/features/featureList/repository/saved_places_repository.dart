import 'package:wdywtg/core/repositories/abstract/repository.dart';
import 'package:wdywtg/features/featureList/model/place_profile.dart';

import '../model/place.dart';

abstract class SavedPlacesRepository extends Repository{

  Future<void> removePlace(Place place);
  Stream<List<PlaceProfile>> placesStream();

}