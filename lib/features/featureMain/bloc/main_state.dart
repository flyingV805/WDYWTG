part of 'main_bloc.dart';

class MainState extends Equatable {

  const MainState._({
    this.askForLocation = false,
    this.displayUserLocation = false,
    this.locationFound = false,
    this.userLocationWeather,
  });

  const MainState.empty() : this._();

  const MainState.requestLocation() : this._(askForLocation: true);
  const MainState.displayLocation() : this._(displayUserLocation: true);
  const MainState.userLocated() : this._(locationFound: true);
  const MainState.updateUserWeather(PlaceWeather userLocationWeather)
    : this._(
      displayUserLocation: true,
      userLocationWeather: userLocationWeather
  );

  final bool askForLocation;
  final bool displayUserLocation;
  final bool locationFound;

  final PlaceWeather? userLocationWeather;

  @override
  List<Object> get props => [
    askForLocation,
    displayUserLocation,
    locationFound,
    userLocationWeather.toString()
  ];
/*
  MainState copyWith({String? name, int? age, String? email}) {
    return User(
      name: name ?? this.name,
      age: age ?? this.age,
      email: email ?? this.email,
    );
  }*/

}