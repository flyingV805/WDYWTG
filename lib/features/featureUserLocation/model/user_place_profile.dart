import 'package:wdywtg/commonModel/place_picture_palette.dart';
import 'package:wdywtg/commonModel/place_weather.dart';
import 'package:wdywtg/features/featureUserLocation/model/user_place.dart';

class UserPlaceProfile {

  final String placeName;
  final String placeCountryCode;
  final String? placePictureUrl;
  final String? placePictureAuthor;
  final String? placePictureAuthorUrl;
  final PlaceWeather? weather;

  UserPlaceProfile({
    required this.placeName,
    required this.placeCountryCode,
    required this.placePictureUrl,
    required this.placePictureAuthor,
    required this.placePictureAuthorUrl,
    required this.weather
  });

  UserPlace toPlace(){
    return UserPlace(
      placeName: placeName,
      placeCountryCode: placeCountryCode,
      placePictureUrl: placePictureUrl,
      placePictureAuthor: placePictureAuthor,
      placePictureAuthorUrl: placePictureAuthorUrl,
      placePicturePalette: PlacePicturePalette.dark
    );
  }

}