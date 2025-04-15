import 'package:shared_preferences/shared_preferences.dart';
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
  void dispose() {}

}