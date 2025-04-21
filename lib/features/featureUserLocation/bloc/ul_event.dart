import 'package:wdywtg/features/featureUserLocation/model/user_place_profile.dart';

sealed class UserLocationEvent {
  const UserLocationEvent();
}

final class Initialize extends UserLocationEvent {}

final class UpdatePlaceData extends UserLocationEvent {

  final UserPlaceProfile? place;

  UpdatePlaceData({ required this.place });

}

final class UserApprovedLocation extends UserLocationEvent {}

final class UserDeclinedLocation extends UserLocationEvent {}