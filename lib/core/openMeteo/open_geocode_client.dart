import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:wdywtg/core/openMeteo/response/search_response.dart';

part 'open_geocode_client.g.dart';

@RestApi(baseUrl: 'https://geocoding-api.open-meteo.com/v1/', parser: Parser.FlutterCompute)
abstract class OpenGeocodeClient {

  factory OpenGeocodeClient(Dio dio, {String? baseUrl}) = _OpenGeocodeClient;

  @GET('search')
  Future<SearchResponse> getAutocomplete(
    @Query("name") String name,
    {
      @Query("count") int count = 5,
      @Query("format") String format = "json",
      @Query("language") String language = "en",
    }
  );

}

FutureOr<SearchResponse> deserializeSearchResponse(Map<String, dynamic> json) => SearchResponse.fromJson(json);
FutureOr<dynamic> serializeSearchResponse(SearchResponse object) => object.toJson();