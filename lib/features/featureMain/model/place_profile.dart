import 'package:wdywtg/features/featureMain/model/place.dart';
import 'package:wdywtg/features/featureMain/model/place_advice.dart';
import 'package:wdywtg/features/featureMain/model/place_weather.dart';

class PlaceProfile {

  final Place place;
  final PlaceWeather? weather;
  final List<PlaceAdvice> advices;

  const PlaceProfile({
    required this.place,
    this.weather,
    this.advices = const []
  });

}