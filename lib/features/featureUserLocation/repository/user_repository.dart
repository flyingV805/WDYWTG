
import '../../../core/repositories/abstract/repository.dart';
import '../model/user_place.dart';

abstract class UserRepository extends Repository {

  Future<bool> needAskForLocation();
  void setNeedAskForLocation(bool value);

  Future<bool> showUserLocation();
  void setShowUserLocation(bool value);

  Future<UserPlace?> lastUserPlace();
  void setLastUserPlace(UserPlace place);

}