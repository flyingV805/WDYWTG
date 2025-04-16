import 'package:floor/floor.dart';

@entity
class SavedPlaceDto {

  @PrimaryKey(autoGenerate: true)
  final int id;

  final String placeName;
  final String placeTimezone;
  final String placeCountryCode;
  final String placePictureUrl;
  final double latitude;
  final double longitude;

  SavedPlaceDto(
    this.id, 
    this.placeName, 
    this.placeTimezone, 
    this.placeCountryCode, 
    this.placePictureUrl, 
    this.latitude, 
    this.longitude
  );

}