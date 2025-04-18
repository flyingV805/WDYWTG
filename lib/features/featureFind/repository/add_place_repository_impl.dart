import 'package:get_it/get_it.dart';
import 'package:wdywtg/features/featureFind/model/add_result.dart';
import 'package:wdywtg/features/featureFind/model/place_suggestion.dart';
import '../../../core/database/dao/saved_place_dao.dart';
import '../../../core/database/dto/saved_place_dto.dart';
import '../../../core/log/loger.dart';
import 'add_place_repository.dart';

class AddPlaceRepositoryImpl extends AddPlaceRepository {

  final _savedPlaceDao = GetIt.I.get<SavedPlaceDao>();
  static final String _logTag = 'AddPlaceRepositoryImpl';

  @override
  Future<AddResult> addSavedPlace(PlaceSuggestion suggestion) async {

    Log().w(_logTag, 'addSavedPlace - ${suggestion.toString()} ${suggestion.timezone}');

    await _savedPlaceDao.insertPlace(
      SavedPlaceDto(
        suggestion.placeId,
        suggestion.placeName,
        suggestion.timezone,
        suggestion.placeCountryCode,
        'https://example.com/berlin.jpg',
        suggestion.latitude,
        suggestion.longitude,
        DateTime.now().millisecondsSinceEpoch ~/ 1000
      )
    );

    return Success();

  }


  @override
  void dispose() {}
}