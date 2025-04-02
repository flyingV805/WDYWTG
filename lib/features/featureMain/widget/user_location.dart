import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          child: SizedBox(
            height: 256,
            child: AnimatedCrossFade(
              crossFadeState: state.locationFound ? CrossFadeState.showSecond : CrossFadeState.showFirst,
              duration: Duration(milliseconds: 250),
              firstChild: _WaitingForLocation(),
              secondChild: _FoundLocation(),
            ),
          )
        ),
      )
    );
  }



}

class _WaitingForLocation extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
    );
  }

}

class _FoundLocation extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [ Text('sdfsdfs') ]
                      )
                    ),
                    VerticalDivider(width: 1, thickness: 1, color: Colors.grey.withAlpha(160),),
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('WED', style: Theme.of(context).textTheme.labelSmall,),
                          Icon(WeatherIcons.day_sunny, size: 16,),
                          Text('-12', style: Theme.of(context).textTheme.labelSmall,),
                        ]
                      )
                    ),
                    VerticalDivider(width: 1, thickness: 1, color: Colors.grey.withAlpha(160),),
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('WED', style: Theme.of(context).textTheme.labelSmall,),
                          Icon(WeatherIcons.day_sunny, size: 16,),
                          Text('-12', style: Theme.of(context).textTheme.labelSmall,),
                        ]
                      )
                    ),
                    VerticalDivider(width: 1, thickness: 1, color: Colors.grey.withAlpha(160),),
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('WED', style: Theme.of(context).textTheme.labelSmall,),
                          Icon(WeatherIcons.day_sunny, size: 16,),
                          Text('-12', style: Theme.of(context).textTheme.labelSmall,),
                        ]
                      )
                    ),
                    VerticalDivider(width: 1, thickness: 1, color: Colors.grey.withAlpha(160),),
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('WED', style: Theme.of(context).textTheme.labelSmall,),
                          Icon(WeatherIcons.day_sunny, size: 16,),
                          Text('-12', style: Theme.of(context).textTheme.labelSmall,),
                        ]
                      )
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }



}