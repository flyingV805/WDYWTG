part of 'main_bloc.dart';

class MainState extends Equatable {

  const MainState._({
    this.askForLocation = false,
    this.displayUserLocation = false,
    this.locationFound = false,
    this.userLocationWeather,
    this.suggestions,
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
  final List<PlaceSuggestion>? suggestions;

  @override
  List<Object> get props => [
    askForLocation,
    displayUserLocation,
    locationFound,
    userLocationWeather.toString(),
    suggestions.toString()
  ];

  MainState copyWith({
    bool? askForLocation,
    bool? displayUserLocation,
    bool? locationFound,
    PlaceWeather? userLocationWeather,
    List<PlaceSuggestion>? suggestions
  }) {
    return MainState._(
      askForLocation: askForLocation ?? this.displayUserLocation,
      displayUserLocation: displayUserLocation ?? this.displayUserLocation,
      locationFound: locationFound ?? this.locationFound,
      userLocationWeather: userLocationWeather ?? this.userLocationWeather,
      suggestions: suggestions ?? this.suggestions,
    );
  }

}