
import '../../../../core/repositories/repository.dart';

abstract class UserRepository extends Repository {

  Future<bool> needAskForLocation();
  void setNeedAskForLocation(bool value);


  Future<bool> showUserLocation();
  void setShowUserLocation(bool value);

}