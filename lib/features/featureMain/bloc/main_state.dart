part of 'main_bloc.dart';

class MainState extends Equatable {

  const MainState._({
    this.askForLocation = false,
    this.displayUserLocation = false,
    this.locationFound = false,
    this.userPlace,
    this.suggestions,
    this.savedPlaces,
  });

  const MainState.empty() : this._();

  const MainState.requestLocation() : this._(askForLocation: true);
  const MainState.displayLocation() : this._(displayUserLocation: true);
  const MainState.userLocated() : this._(locationFound: true);
  /*const MainState.updateUserWeather(PlaceWeather userLocationWeather)
    : this._(
      displayUserLocation: true,
      userLocationWeather: userLocationWeather
  );*/

  final bool askForLocation;
  final bool displayUserLocation;
  final bool locationFound;

  final UserPlace? userPlace;
  final List<PlaceSuggestion>? suggestions;
  final List<PlaceProfile>? savedPlaces;

  @override
  List<Object> get props => [
    askForLocation,
    displayUserLocation,
    locationFound,
    userPlace.toString(),
    suggestions.toString()
  ];

  MainState copyWith({
    bool? askForLocation,
    bool? displayUserLocation,
    bool? locationFound,
    UserPlace? userPlace,
    List<PlaceSuggestion>? suggestions,
    List<PlaceProfile>? savedPlaces
  }) {
    return MainState._(
      askForLocation: askForLocation ?? this.displayUserLocation,
      displayUserLocation: displayUserLocation ?? this.displayUserLocation,
      locationFound: locationFound ?? this.locationFound,
      userPlace: userPlace ?? this.userPlace,
      suggestions: suggestions ?? this.suggestions,
      savedPlaces: savedPlaces ?? this.savedPlaces,
    );
  }

}