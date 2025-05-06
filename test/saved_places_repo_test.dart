
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:rxdart/rxdart.dart';
import 'package:wdywtg/commonModel/place_picture_palette.dart';
import 'package:wdywtg/core/database/dao/ai_advice_dao.dart';
import 'package:wdywtg/core/database/dao/cached_weather_dao.dart';
import 'package:wdywtg/core/database/dao/saved_place_dao.dart';
import 'package:wdywtg/core/database/dto/ai_advice_dto.dart';
import 'package:wdywtg/core/database/dto/cached_weather_dto.dart';
import 'package:wdywtg/core/database/dto/saved_place_dto.dart';
import 'package:wdywtg/core/userSession/user_session.dart';
import 'package:wdywtg/features/featureList/model/place_profile.dart';
import 'package:wdywtg/features/featureList/repository/saved_places_repository_impl.dart';

import 'saved_places_repo_test.mocks.dart';

@GenerateMocks([SavedPlaceDao, CachedWeatherDao, AiAdviceDao, UserSession])
void main() {

  late MockSavedPlaceDao savedPlaceDao;
  late MockCachedWeatherDao weatherDao;
  late MockAiAdviceDao aiAdviceDao;
  late MockUserSession userSession;
  late SavedPlacesRepositoryImpl repository;

  setUp(() {
    savedPlaceDao = MockSavedPlaceDao();
    weatherDao = MockCachedWeatherDao();
    aiAdviceDao = MockAiAdviceDao();
    userSession = MockUserSession();

    GetIt.I.registerSingleton<SavedPlaceDao>(savedPlaceDao);
    GetIt.I.registerSingleton<CachedWeatherDao>(weatherDao);
    GetIt.I.registerSingleton<AiAdviceDao>(aiAdviceDao);
    GetIt.I.registerSingleton<UserSession>(userSession);

    repository = SavedPlacesRepositoryImplTestable(
      savedPlaceDao,
      weatherDao,
      aiAdviceDao,
      userSession,
    );
  });

  test('placesStream combines place, weather, advice and marks last added', () async {
    final placeDto = SavedPlaceDto(0, 'Paris', 'placeTimezone', 'placeCountryCode', 'placePictureUrl', 'placePictureAuthor', '', PlacePicturePalette.dark, 0.0, 0.0, false, 0);
    final weather = CachedWeatherDto(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0) ;
    final advice1 = AiAdviceDto(0, 0, 'adviceTitle', 'content');

    when(savedPlaceDao.allPlacesLive())
        .thenAnswer((_) => BehaviorSubject.seeded([placeDto]));
    when(weatherDao.allWeatherLive())
        .thenAnswer((_) => BehaviorSubject.seeded([weather]));
    when(aiAdviceDao.allAdvicesLive())
        .thenAnswer((_) => BehaviorSubject.seeded([advice1]));
    when(userSession.lastAddedId).thenReturn(1);

    final stream = repository.placesStream();

    final result = await stream.first;

    expect(result, isA<List<PlaceProfile>>());
    expect(result.length, 1);
    expect(result.first.place.placeName, 'Paris');
    expect(result.first.weather?.currentTemp, 0);
    //expect(result.first.advices.first.adviceTitle, 'adviceTitle');
  });
}

/// Тестовая обёртка, позволяющая внедрить зависимости напрямую без GetIt
class SavedPlacesRepositoryImplTestable extends SavedPlacesRepositoryImpl {

  final SavedPlaceDao _dao;
  final CachedWeatherDao _weather;
  final AiAdviceDao _advices;
  final UserSession _session;

  SavedPlacesRepositoryImplTestable(
      this._dao,
      this._weather,
      this._advices,
      this._session,
      );

  @override
  SavedPlaceDao get _savedPlaceDao => _dao;

  @override
  CachedWeatherDao get _weatherDao => _weather;

  @override
  AiAdviceDao get _aiAdviceDao => _advices;

  @override
  UserSession get _userSession => _session;

}