import 'package:wdywtg/commonModel/place_picture_palette.dart';

class Place {

  final int id;
  final String placeName;
  final String placeTimezone;
  final String placeCountryCode;
  final String placePictureUrl;
  final String placePictureAuthor;
  final PlacePicturePalette? placePicturePalette;
  final double latitude;
  final double longitude;

  Place({
    required this.id,
    required this.placeName,
    required this.placeTimezone,
    required this.placeCountryCode,
    required this.placePictureUrl,
    required this.placePictureAuthor,
    required this.placePicturePalette,
    required this.latitude,
    required this.longitude,
  });
  
  Place.examplePlace() : this(
    id: 0,
    placeName: 'Berlin',
    placeTimezone: 'Europe/Berlin',
    placeCountryCode: 'DE',
    placePictureUrl: 'https://example.com/berlin.jpg',
    placePictureAuthor: '',
    placePicturePalette: PlacePicturePalette.dark,
    latitude: 52.5200,
    longitude: 13.4050 
  );

}