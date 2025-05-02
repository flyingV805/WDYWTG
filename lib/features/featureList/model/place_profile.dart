import 'package:wdywtg/features/featureList/model/place.dart';
import 'package:wdywtg/features/featureList/model/place_advice.dart';
import 'package:wdywtg/commonModel/place_weather.dart';

class PlaceProfile {

  final Place place;
  final PlaceWeather? weather;
  final bool advicesAvailable;
  final List<PlaceAdvice> advices;

  const PlaceProfile({
    required this.place,
    this.weather,
    this.advicesAvailable = true,
    this.advices = const []
  });

}