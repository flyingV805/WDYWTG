import 'package:wdywtg/features/featureUserLocation/model/user_place_profile.dart';

sealed class UserLocationEvent {
  const UserLocationEvent();
}

final class Initialize extends UserLocationEvent {}

final class UpdatePlaceData extends UserLocationEvent {

  final UserPlaceProfile? place;

  UpdatePlaceData({ required this.place });

}
//
final class RetryLocation extends UserLocationEvent {}

final class RetryWeather extends UserLocationEvent {}

final class RetryImage extends UserLocationEvent {}

final class SkipImage extends UserLocationEvent {}

final class RetryGeocode extends UserLocationEvent {}

final class SkipGeocode extends UserLocationEvent {}

final class DisableFeature extends UserLocationEvent {}
//
final class UserApprovedLocation extends UserLocationEvent {}

final class UserDeclinedLocation extends UserLocationEvent {}
