import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wdywtg/features/featureMain/model/place_weather.dart';
import 'package:wdywtg/uiKit/weatherRow/weather_row.dart';
import 'package:weather_icons/weather_icons.dart';

import '../bloc/main_bloc.dart';

class UserLocation extends StatelessWidget {

  const UserLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: AnimatedSize(
            duration: Duration(milliseconds: 250),
            child: SizedBox(
              height: state.displayUserLocation ? 256 : 0,
              child: AnimatedCrossFade(
                crossFadeState: state.userLocationWeather == null
                  ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                duration: Duration(milliseconds: 250),
                firstChild: _WaitingForWeather(),
                secondChild: _WeatherFound(
                  weather: state.userLocationWeather
                )
              ),
            ),
          )
        ),
      )
    );
  }

}

class _WaitingForWeather extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('user_weather_preload_widget'),
      color: Colors.red,
    );
  }

}

class _WeatherFound extends StatelessWidget {

  final PlaceWeather? weather;

  const _WeatherFound({required this.weather});

  @override
  Widget build(BuildContext context) {
    return Stack(
      key: const Key('user_weather_widget'),
      children: [
        Image.asset(
          'assets/image/florida.png',
          width: double.infinity,
          height: 256,
          fit: BoxFit.fill
        ),
        // Location name
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Florida, US', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
          )
        ),
        // 'You are here'
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(12), bottomLeft: Radius.circular(12))
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.location_on),
                    SizedBox(width: 4),
                    Text('You are here')
                  ],
                ),
              ),
            ),
          ),
        ),
        // Weather
        Align(
          alignment: Alignment.bottomCenter,
          child: ClipRect(  // <-- clips to the 200x200 [Container] below
            child: BackdropFilter(
              filter: ui.ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: SizedBox(
                width: double.infinity,
                height: 78.0,
                child: WeatherRow()
              ),
            ),
          ),
        ),
      ],
    );
  }



}