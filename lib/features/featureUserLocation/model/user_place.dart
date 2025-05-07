
import 'package:wdywtg/commonModel/place_picture_palette.dart';

class UserPlace {

  final String placeName;
  final String placeCountryCode;
  final String? placePictureUrl;
  final String? placePictureAuthor;
  final String? placePictureAuthorUrl;
  final PlacePicturePalette? placePicturePalette;

  UserPlace({
    required this.placeName,
    required this.placeCountryCode,
    required this.placePictureUrl,
    required this.placePictureAuthor,
    required this.placePictureAuthorUrl,
    required this.placePicturePalette
  });


}