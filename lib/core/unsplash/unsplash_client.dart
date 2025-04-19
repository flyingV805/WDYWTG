import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:wdywtg/core/unsplash/response/unsplash_response.dart';

part 'unsplash_client.g.dart';

@RestApi(baseUrl: 'https://api.unsplash.com/', parser: Parser.FlutterCompute)
abstract class UnsplashClient {

  factory UnsplashClient(Dio dio, {String? baseUrl}) = _UnsplashClient;

  @GET('search/photos')
  Future<UnsplashResponse> getPicture(
    @Query("query") String name,
    @Header("Authorization") String authString,
    {
      @Query("per_page") int perPage = 1,
      @Query("orientation") String orientation = 'landscape',
    }
  );

}

FutureOr<UnsplashResponse> deserializeUnsplashResponse(Map<String, dynamic> json) => UnsplashResponse.fromJson(json);
FutureOr<dynamic> serializeUnsplashResponse(UnsplashResponse object) => object.toJson();