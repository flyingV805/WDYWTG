import 'package:wdywtg/features/featureUserLocation/model/place_setup_response.dart';

import '../../../core/repositories/abstract/repository.dart';
import '../model/user_place_profile.dart';

abstract class UserRepository extends Repository {

  Future<bool> needAskForLocation();
  void setNeedAskForLocation(bool value);

  Future<bool> showUserLocation();
  void setShowUserLocation(bool value);

  Future<PlaceSetupResponse> updateUserPlace(double latitude, double longitude);
  Stream<UserPlaceProfile?> userPlaceLive();

  Future<PlaceSetupResponse> skipGeocode();
  Future<PlaceSetupResponse> retryFromWeather();
  Future<PlaceSetupResponse> retryFromImage();

}