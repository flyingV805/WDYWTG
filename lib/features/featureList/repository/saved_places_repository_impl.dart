import 'package:collection/collection.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:wdywtg/core/database/dao/ai_advice_dao.dart';
import 'package:wdywtg/core/database/dao/cached_weather_dao.dart';
import 'package:wdywtg/core/database/dao/saved_place_dao.dart';
import 'package:wdywtg/core/database/dto/saved_place_dto.dart';
import 'package:wdywtg/features/featureList/model/place_profile.dart';
import 'package:wdywtg/features/featureList/repository/mapper/place_mapper.dart';
import 'package:wdywtg/features/featureList/repository/saved_places_repository.dart';

class SavedPlacesRepositoryImpl extends SavedPlacesRepository {

  final _savedPlaceDao = GetIt.I.get<SavedPlaceDao>();
  final _weatherDao = GetIt.I.get<CachedWeatherDao>();
  final _aiAdviceDao = GetIt.I.get<AiAdviceDao>();

  @override
  Stream<List<PlaceProfile>> placesStream(){

    final placesStream = _savedPlaceDao.allPlacesLive();
    final weatherStream = _weatherDao.allWeatherLive();
    final advicesStream = _aiAdviceDao.allAdvicesLive();

    // weather and advices with empty list,
    // to make ui more responsive when adding place happened
    return CombineLatestStream.combine3(
      placesStream, 
      weatherStream.startWith([]),
      advicesStream.startWith([]),
      (places, weather, advices) {
        return places.map((place)=> 
          mapPlaceProfile(
            place, 
            weather.firstWhereOrNull(((item) => item.placeId == place.id)), 
            advices.where((item) => item.placeId == place.id)
          )
        ).toList();
      }
    );
  }

    
  @override
  void dispose() { }

  @override
  void testInsert() {
    _savedPlaceDao.insertPlace(SavedPlaceDto(1,
        'Darmshdadt',
        'Europe/Berlin',
        'DE',
        'https://example.com/berlin.jpg',
        52.5200,
        13.4050 ));

  }

}