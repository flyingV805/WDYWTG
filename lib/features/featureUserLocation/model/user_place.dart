import 'package:wdywtg/commonModel/place_weather.dart';

class UserPlace {

  final String placeName;
  final String placeCountryCode;
  final String placePictureUrl;
  final double latitude;
  final double longitude;

  UserPlace({
    required this.placeName,
    required this.placeCountryCode,
    required this.placePictureUrl,
    required this.latitude,
    required this.longitude,
  });


}