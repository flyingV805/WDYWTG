import 'package:wdywtg/core/repositories/abstract/repository.dart';
import 'package:wdywtg/features/featureList/model/place_profile.dart';

abstract class SavedPlacesRepository extends Repository{

  Stream<List<PlaceProfile>> placesStream();
  void testInsert();

}