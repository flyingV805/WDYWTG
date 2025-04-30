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
    this.error,
  });

  const UserLocationState.empty() : this._();

  final bool askForLocation;
  final bool displayUserLocation;
  final bool locationFound;
  final UserPlace? userPlace;
  final PlaceWeather? weather;
  final UserLocationError? error;

  @override
  List<Object?> get props => [
    askForLocation,
    displayUserLocation,
    locationFound,
    userPlace,
    weather,
    error ?? Empty
  ];

  UserLocationState copyWith({
    bool? askForLocation,
    bool? displayUserLocation,
    bool? locationFound,
    UserPlace? userPlace,
    PlaceWeather? weather,
    UserLocationError? error
  }) {
    return UserLocationState._(
      askForLocation: askForLocation ?? this.askForLocation,
      displayUserLocation: displayUserLocation ?? this.displayUserLocation,
      locationFound: locationFound ?? this.locationFound,
      userPlace: userPlace ?? this.userPlace,
      weather: weather ?? this.weather,
      error: error ?? this.error
    );
  }

}

sealed class UserLocationError {}

final class Empty extends UserLocationError {}

final class PermissionDeclinedError extends UserLocationError {

  final bool isForever;

  PermissionDeclinedError({required this.isForever});

}

final class ServiceDisabledError extends UserLocationError {}

final class FetchLocationError extends UserLocationError {}

final class GeocodeError extends UserLocationError {}

final class GetWeatherError extends UserLocationError {}

final class GetImageError extends UserLocationError {}