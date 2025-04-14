import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wdywtg/features/featureUserLocation/bloc/ul_bloc.dart';
import 'package:wdywtg/features/featureUserLocation/bloc/ul_state.dart';

import 'bloc/ul_event.dart';

class UserLocation extends StatelessWidget {

  const UserLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext blocContext) => UserLocationBloc(
        //weatherRepository: blocContext.read<WeatherRepository>(),
        //userRepository: blocContext.read<UserRepository>()
      )..add(Initialize()),
      child:  BlocBuilder<UserLocationBloc, UserLocationState>(
      builder: (context, state) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: AnimatedSize(
            duration: Duration(milliseconds: 250),
            child: SizedBox(
              height: state.displayUserLocation ? 256 : 0,
              child: AnimatedCrossFade(
                crossFadeState: state.locationFound ?
                  CrossFadeState.showFirst : CrossFadeState.showSecond,
                duration: Duration(milliseconds: 250),
                firstChild: SizedBox(),
                secondChild: SizedBox()
              ),
            ),
          )
        ),
      )),
    );
  }

}