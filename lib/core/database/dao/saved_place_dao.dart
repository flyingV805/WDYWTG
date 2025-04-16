import 'package:floor/floor.dart';
import 'package:wdywtg/core/database/dto/saved_place_dto.dart';

@dao
abstract class SavedPlaceDao {

  @Query('SELECT * FROM SavedPlaceDTO')
  Future<List<SavedPlaceDto>> findAllPeople();

  @Query('SELECT name FROM Person')
  Stream<List<String>> findAllPeopleName();

  @Query('SELECT * FROM Person WHERE id = :id')
  Stream<SavedPlaceDto?> findPersonById(int id);

  @insert
  Future<void> insertPerson(SavedPlaceDto place);
  
}