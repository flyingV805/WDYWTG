import 'package:floor/floor.dart';
import 'package:wdywtg/core/database/dto/saved_place_dto.dart';

import '../constants.dart';

@dao
abstract class SavedPlaceDao {

  @Query('SELECT * FROM SavedPlaceDTO')
  Future<List<SavedPlaceDto>> getAllPlaces();

  @Query('SELECT * FROM SavedPlaceDTO WHERE id != ${Constants.userPlaceId} ORDER BY addTime DESC')
  Stream<List<SavedPlaceDto>> allPlacesLive();

  @Query('SELECT * FROM SavedPlaceDTO WHERE id = :placeId')
  Stream<SavedPlaceDto?> placeLive(int placeId);

  @Query('SELECT * FROM SavedPlaceDTO WHERE id = ${Constants.userPlaceId}')
  Future<SavedPlaceDto?> getUserPlace();

  @Insert(onConflict: OnConflictStrategy.abort)
  Future<void> insertPlace(SavedPlaceDto place);

  @update
  Future<void> updatePlace(SavedPlaceDto place);
  
}