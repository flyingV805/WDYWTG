// required package imports
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:wdywtg/core/database/dao/ai_advice_dao.dart';
import 'package:wdywtg/core/database/dao/cached_weather_dao.dart';
import 'package:wdywtg/core/database/dao/saved_place_dao.dart';
import 'package:wdywtg/core/database/dto/ai_advice_dto.dart';
import 'package:wdywtg/core/database/dto/cached_weather_dto.dart';
import 'package:wdywtg/core/database/dto/saved_place_dto.dart';

part 'app_database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [SavedPlaceDto, AiAdviceDto, CachedWeatherDto])
abstract class AppDatabase extends FloorDatabase {
  SavedPlaceDao get placesDao;
  CachedWeatherDao get weatherDao;
  AiAdviceDao get aiAdviceDao;
}