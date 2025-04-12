import 'package:wdywtg/features/featureMain/model/place_weather.dart';

class UserPlace {

  final String placeName;
  final String placeCountryCode;
  final String placePictureUrl;
  final PlaceWeather? weather;

  UserPlace({
    required this.placeName,
    required this.placeCountryCode,
    required this.placePictureUrl,
    this.weather
  });


}