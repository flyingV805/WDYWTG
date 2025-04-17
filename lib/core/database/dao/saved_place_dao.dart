import 'package:floor/floor.dart';
import 'package:wdywtg/core/database/dto/saved_place_dto.dart';

@dao
abstract class SavedPlaceDao {

  @Query('SELECT * FROM SavedPlaceDTO')
  Future<List<SavedPlaceDto>> getAllPlaces();

  @Query('SELECT * FROM SavedPlaceDTO')
  Stream<List<SavedPlaceDto>> allPlacesLive();

  @insert
  Future<void> insertPlace(SavedPlaceDto place);
  
}