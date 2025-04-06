part of 'main_bloc.dart';


class MainState extends Equatable {

  const MainState._({
    this.askForLocation = false,
    this.displayLocation = false,
    this.locationFound = false,
  });

  const MainState.empty() : this._();

  const MainState.requestLocation() : this._(askForLocation: true);
  const MainState.displayLocation() : this._(displayLocation: true);
  const MainState.userLocated() : this._(locationFound: true);

  final bool askForLocation;
  final bool displayLocation;
  final bool locationFound;

  @override
  List<Object> get props => [askForLocation, displayLocation, locationFound];

}