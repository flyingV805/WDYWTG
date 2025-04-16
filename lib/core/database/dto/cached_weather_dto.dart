import 'package:floor/floor.dart';

@entity
class CachedWeatherDto {

  @PrimaryKey(autoGenerate: true)
  final int id;
  final int placeId;

  final double latitude;
  final double longitude;
  final int updateTime; 

  final int currentCode;
  final int currentTemp;

  final int forecastDayOfWeek0;
  final int forecastCode0;
  final int forecastTempMin0;
  final int forecastTempMax0;

  final int forecastDayOfWeek1;
  final int forecastCode1;
  final int forecastTempMin1;
  final int forecastTempMax1;

  final int forecastDayOfWeek2;
  final int forecastCode2;
  final int forecastTempMin2;
  final int forecastTempMax2;

  final int forecastDayOfWeek3;
  final int forecastCode3;
  final int forecastTempMin3;
  final int forecastTempMax3;

  CachedWeatherDto(
    this.id,
    this.placeId,
    this.latitude,
    this.longitude,
    this.updateTime,
    this.currentCode,
    this.currentTemp,
    this.forecastDayOfWeek0,
    this.forecastCode0,
    this.forecastTempMin0,
    this.forecastTempMax0,
    this.forecastDayOfWeek1,
    this.forecastCode1,
    this.forecastTempMin1,
    this.forecastTempMax1,
    this.forecastDayOfWeek2,
    this.forecastCode2,
    this.forecastTempMin2,
    this.forecastTempMax2,
    this.forecastDayOfWeek3,
    this.forecastCode3,
    this.forecastTempMin3,
    this.forecastTempMax3
  );

}