import 'package:collection/collection.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:wdywtg/core/database/dao/ai_advice_dao.dart';
import 'package:wdywtg/core/database/dao/cached_weather_dao.dart';
import 'package:wdywtg/core/database/dao/saved_place_dao.dart';
import 'package:wdywtg/features/featureList/model/place_profile.dart';
import 'package:wdywtg/features/featureList/repository/mapper/place_mapper.dart';
import 'package:wdywtg/features/featureList/repository/saved_places_repository.dart';

import '../../../core/userSession/user_session.dart';
import '../model/place.dart';

class SavedPlacesRepositoryImpl extends SavedPlacesRepository {

  final _savedPlaceDao = GetIt.I.get<SavedPlaceDao>();
  final _weatherDao = GetIt.I.get<CachedWeatherDao>();
  final _aiAdviceDao = GetIt.I.get<AiAdviceDao>();
  final _userSession = GetIt.I.get<UserSession>();

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
        final lastPlaceId = _userSession.lastAddedId;
        return places.map((place)=> 
          mapPlaceProfile(
            place, 
            weather.firstWhereOrNull(((item) => item.placeId == place.id)), 
            advices.where((item) => item.placeId == place.id),
            lastPlaceId == place.id
          )
        ).toList();
      }
    );
  }


  @override
  Future<void> removePlace(Place place) async {
    await _savedPlaceDao.deletePlace(place.id);
    await _weatherDao.deleteWeather(place.id);
    await _aiAdviceDao.deleteAdvices(place.id);
  }
    
  @override
  void dispose() { }

}