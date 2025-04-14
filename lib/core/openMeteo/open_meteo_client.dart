import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:wdywtg/core/openMeteo/response/forecast_response.dart';
import 'package:wdywtg/core/openMeteo/response/search_response.dart';

part 'open_meteo_client.g.dart';

@RestApi(baseUrl: 'https://api.open-meteo.com/v1/', parser: Parser.FlutterCompute)
abstract class OpenMeteoClient {

  factory OpenMeteoClient(Dio dio, {String? baseUrl}) = _OpenMeteoClient;

  // https://api.open-meteo.com/v1/forecast?latitude=54.88023822036019&longitude=69.13817940731532&hourly=temperature_2m,weather_code&current=temperature_2m,weather_code
  @GET('forecast')
  Future<ForecastResponse> getForecast(
    @Query("latitude") double latitude,
    @Query("longitude") double longitude,
    {
      @Query("current") String current = "temperature_2m,weather_code",
      @Query("daily") String daily = "weather_code,temperature_2m_max,temperature_2m_min",
    }
  );

}


FutureOr<ForecastResponse> deserializeForecastResponse(Map<String, dynamic> json) => ForecastResponse.fromJson(json);
FutureOr<dynamic> serializeForecastResponse(ForecastResponse object) => object.toJson();