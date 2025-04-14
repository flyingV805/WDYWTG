import 'package:equatable/equatable.dart';

class UserLocationState extends Equatable {

  const UserLocationState._({
    this.askForLocation = false,
    this.displayUserLocation = false,
    this.locationFound = false,
  });

  const UserLocationState.empty() : this._();

  final bool askForLocation;
  final bool displayUserLocation;
  final bool locationFound;

  @override
  List<Object?> get props => throw UnimplementedError();

}