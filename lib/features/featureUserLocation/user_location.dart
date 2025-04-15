import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wdywtg/features/featureUserLocation/bloc/ul_bloc.dart';
import 'package:wdywtg/features/featureUserLocation/bloc/ul_state.dart';
import 'package:wdywtg/features/featureUserLocation/repository/user_repository.dart';
import 'package:wdywtg/features/featureUserLocation/widget/preloader.dart';
import 'package:wdywtg/features/featureUserLocation/widget/user_place.dart';

import '../../core/repositories/weather/weather_repository.dart';
import 'bloc/ul_event.dart';
import 'dialog/ask_for_location.dart';

class UserLocation extends StatelessWidget {

  const UserLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext blocContext) => UserLocationBloc(
        weatherRepository: blocContext.read<WeatherRepository>(),
        userRepository: blocContext.read<UserRepository>()
      )..add(Initialize()),
      child:  BlocListener<UserLocationBloc, UserLocationState>(
        listener: (context, state) {
          if(state.askForLocation) { askForLocationDialog(context); }
        },
        child: BlocBuilder<UserLocationBloc, UserLocationState>(
        builder: (context, state) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: AnimatedSize(
              duration: Duration(milliseconds: 250),
              child: SizedBox(
                height: state.displayUserLocation ? 186 : 0,
                child: AnimatedCrossFade(
                  crossFadeState: state.locationFound ?
                    CrossFadeState.showFirst : CrossFadeState.showSecond,
                  duration: Duration(milliseconds: 250),
                  firstChild: UserPlaceWidget(
                    place: state.userPlace,
                    weather: state.weather
                  ),
                  secondChild: Preloader()
                ),
              ),
            )
          ),
        )),
      ),
    );
  }

}