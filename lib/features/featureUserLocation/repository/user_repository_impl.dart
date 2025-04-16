import 'package:shared_preferences/shared_preferences.dart';
import 'package:wdywtg/features/featureUserLocation/model/user_place.dart';
import 'package:wdywtg/features/featureUserLocation/repository/user_repository.dart';

class UserRepositoryImpl extends UserRepository {

  final _preferences = SharedPreferencesAsync();

  @override
  Future<bool> needAskForLocation() async {
    final result = await _preferences.getBool('needAskForLocation') ?? true;
    return result;
  }

  @override
  void setNeedAskForLocation(bool value) {
    _preferences.setBool('needAskForLocation', value);
  }

  @override
  void setShowUserLocation(bool value) {
    _preferences.setBool('showUserLocation', value);
  }

  @override
  Future<bool> showUserLocation() async {
    final result = await _preferences.getBool('showUserLocation') ?? false;
    return result;
  }

  @override
  Future<UserPlace?> lastUserPlace() async {
    final placeName = await _preferences.getString('placeName');
    if(placeName == null) { return null; }

    final String placeCountryCode = await _preferences.getString('placeCountryCode') ?? '';
    final String placePictureUrl = await _preferences.getString('placePictureUrl') ?? '';
    final double latitude = await _preferences.getDouble('latitude') ?? 0.0;
    final double longitude = await _preferences.getDouble('longitude') ?? 0.0;

    return UserPlace(
      placeName: placeName,
      placeCountryCode: placeCountryCode,
      placePictureUrl: placePictureUrl,
      latitude: latitude,
      longitude: longitude
    );
  }

  @override
  void setLastUserPlace(UserPlace place) {
    _preferences.setString('placeName', place.placeName);
    _preferences.setString('placeCountryCode', place.placeCountryCode);
    _preferences.setString('placePictureUrl', place.placePictureUrl);
    _preferences.setDouble('latitude', place.latitude);
    _preferences.setDouble('longitude', place.longitude);
  }

  @override
  void dispose() {}

}