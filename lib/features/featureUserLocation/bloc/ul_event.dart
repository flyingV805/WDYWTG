
sealed class UserLocationEvent {
  const UserLocationEvent();
}

final class Initialize extends UserLocationEvent {}


final class UserApprovedLocation extends UserLocationEvent {}

final class UserDeclinedLocation extends UserLocationEvent {}