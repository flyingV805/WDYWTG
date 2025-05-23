import 'package:wdywtg/commonModel/place_picture_palette.dart';

class Place {

  final int id;
  final String placeName;
  final String placeTimezone;
  final String placeCountryCode;
  final String placePictureUrl;
  final String placePictureAuthor;
  final String placePictureAuthorUrl;
  final PlacePicturePalette? placePicturePalette;
  final double latitude;
  final double longitude;
  final bool lastAdded;

  Place({
    required this.id,
    required this.placeName,
    required this.placeTimezone,
    required this.placeCountryCode,
    required this.placePictureUrl,
    required this.placePictureAuthor,
    required this.placePictureAuthorUrl,
    required this.placePicturePalette,
    required this.latitude,
    required this.longitude,
    required this.lastAdded,
  });
  
  Place.examplePlace() : this(
    id: 0,
    placeName: 'Paris',
    placeTimezone: 'Europe/Paris',
    placeCountryCode: 'FR',
    placePictureUrl: '',
    placePictureAuthor: '',
    placePictureAuthorUrl: '',
    placePicturePalette: PlacePicturePalette.dark,
    latitude: 52.5200,
    longitude: 13.4050 ,
    lastAdded: false
  );

}