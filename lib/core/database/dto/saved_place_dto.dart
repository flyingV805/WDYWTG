import 'package:floor/floor.dart';

import '../../../commonModel/place_picture_palette.dart';

@entity
class SavedPlaceDto {

  @PrimaryKey(autoGenerate: true)
  final int id;

  final String placeName;
  final String placeTimezone;
  final String placeCountryCode;
  final String? placePictureUrl;
  final String? placePictureAuthor;
  final PlacePicturePalette? placePicturePalette;
  final double latitude;
  final double longitude;
  final bool advicesAvailable;
  final int addTime;

  SavedPlaceDto(
    this.id, 
    this.placeName, 
    this.placeTimezone, 
    this.placeCountryCode, 
    this.placePictureUrl,
    this.placePictureAuthor,
    this.placePicturePalette,
    this.latitude, 
    this.longitude,
    this.advicesAvailable,
    this.addTime
  );

}