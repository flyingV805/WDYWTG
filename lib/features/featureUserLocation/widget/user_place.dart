import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import '../../../commonModel/place_weather.dart';
import '../../../uiKit/weatherRow/weather_row.dart';
import '../model/user_place.dart';

class UserPlaceWidget extends StatelessWidget {

  final UserPlace? place;
  final PlaceWeather? weather;

  const UserPlaceWidget({
    super.key,
    required this.place,
    required this.weather
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      key: const Key('user_weather_widget'),
      children: [
        Image.asset(
          'assets/image/florida.png',
          width: double.infinity,
          height: 186,
          fit: BoxFit.fill
        ),
        // Location name
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${place?.placeName ?? ''}, ${place?.placeCountryCode ?? ''}', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                Text('Photo by Vvvv Hhhhhh (Unsplash)', style: Theme.of(context).textTheme.labelSmall)
              ],
            ),
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
                child: WeatherRow(weather: weather)
              ),
            ),
          ),
        ),
      ],
    );
  }



}