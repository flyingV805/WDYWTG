import 'package:wdywtg/commonModel/place_weather.dart';
import 'package:wdywtg/core/database/dto/cached_weather_dto.dart';

PlaceWeather? mapWeatherDtoToModel(CachedWeatherDto? weatherDto){
  if(weatherDto == null) return null;
  return PlaceWeather(
    currentCode: weatherDto.currentCode,
    currentTemp: weatherDto.currentTemp,
    forecastDateTime0: weatherDto.forecastDateTime0,
    forecastCode0: weatherDto.forecastCode0,
    forecastTempMin0: weatherDto.forecastTempMin0,
    forecastTempMax0: weatherDto.forecastTempMax0,
    forecastDateTime1: weatherDto.forecastDateTime1,
    forecastCode1: weatherDto.forecastCode1,
    forecastTempMin1: weatherDto.forecastTempMin1,
    forecastTempMax1: weatherDto.forecastTempMax1,
    forecastDateTime2: weatherDto.forecastDateTime2,
    forecastCode2: weatherDto.forecastCode2,
    forecastTempMin2: weatherDto.forecastTempMin2,
    forecastTempMax2: weatherDto.forecastTempMax2,
    forecastDateTime3: weatherDto.forecastDateTime3,
    forecastCode3: weatherDto.forecastCode3,
    forecastTempMin3: weatherDto.forecastTempMin3,
    forecastTempMax3: weatherDto.forecastTempMax3,
  );
}