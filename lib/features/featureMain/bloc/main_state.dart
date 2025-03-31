part of 'main_bloc.dart';


class MainState extends Equatable {

  const MainState._({
    this.locationFound = false,
  });

  const MainState.empty() : this._();

  const MainState.userLocated() : this._(locationFound: true);

  final bool locationFound;

  @override
  List<Object> get props => [];

}