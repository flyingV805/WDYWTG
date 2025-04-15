import 'package:equatable/equatable.dart';
import 'package:wdywtg/commonModel/place_weather.dart';

import '../model/user_place.dart';

class UserLocationState extends Equatable {

  const UserLocationState._({
    this.askForLocation = false,
    this.displayUserLocation = false,
    this.locationFound = false,
    this.userPlace,
    this.weather,
  });

  const UserLocationState.empty() : this._();

  final bool askForLocation;
  final bool displayUserLocation;
  final bool locationFound;
  final UserPlace? userPlace;
  final PlaceWeather? weather;

  @override
  List<Object?> get props => [
    askForLocation,
    displayUserLocation,
    locationFound,
    userPlace,
    weather
  ];

  UserLocationState copyWith({
    bool? askForLocation,
    bool? displayUserLocation,
    bool? locationFound,
    UserPlace? userPlace,
    PlaceWeather? weather
  }) {
    return UserLocationState._(
      askForLocation: askForLocation ?? this.askForLocation,
      displayUserLocation: displayUserLocation ?? this.displayUserLocation,
      locationFound: locationFound ?? this.locationFound,
      userPlace: userPlace ?? this.userPlace,
      weather: weather ?? this.weather
    );
  }

}