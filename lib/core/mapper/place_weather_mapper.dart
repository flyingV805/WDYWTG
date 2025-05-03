import 'package:intl/intl.dart';
import 'package:wdywtg/core/database/dto/cached_weather_dto.dart';
import 'package:wdywtg/core/openMeteo/response/forecast_response.dart';

CachedWeatherDto mapFromNetwork(
  ForecastResponse networkResponse,
  int placeId,
  double latitude,
  double longitude
){

  final datetimeFormat = DateFormat('yyyy-MM-dd');

  return CachedWeatherDto(
    placeId,
    latitude,
    longitude,
    DateTime.now().millisecondsSinceEpoch ~/ 1000,
    networkResponse.current?.code ?? 0,
    networkResponse.current?.temperature.toInt() ?? 0,

    datetimeFormat.tryParse(networkResponse.daily?.time[1] ?? '', true)?.millisecondsSinceEpoch ?? 0,
    networkResponse.daily?.code[1] ?? 0,
    networkResponse.daily?.temperatureMin[1].toInt() ?? 0,
    networkResponse.daily?.temperatureMax[1].toInt() ?? 0,
    datetimeFormat.tryParse(networkResponse.daily?.time[2] ?? '', true)?.millisecondsSinceEpoch ?? 0,
    networkResponse.daily?.code[2] ?? 0,
    networkResponse.daily?.temperatureMin[2].toInt() ?? 0,
    networkResponse.daily?.temperatureMax[2].toInt() ?? 0,
    datetimeFormat.tryParse(networkResponse.daily?.time[3] ?? '', true)?.millisecondsSinceEpoch ?? 0,
    networkResponse.daily?.code[3] ?? 0,
    networkResponse.daily?.temperatureMin[3].toInt() ?? 0,
    networkResponse.daily?.temperatureMax[3].toInt() ?? 0,
    datetimeFormat.tryParse(networkResponse.daily?.time[4] ?? '', true)?.millisecondsSinceEpoch ?? 0,
    networkResponse.daily?.code[4] ?? 0,
    networkResponse.daily?.temperatureMin[4].toInt() ?? 0,
    networkResponse.daily?.temperatureMax[4].toInt() ?? 0,
  );

}