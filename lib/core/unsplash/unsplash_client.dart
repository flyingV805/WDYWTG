import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'unsplash_client.g.dart';

@RestApi(baseUrl: 'https://api.unsplash.com/'/*, parser: Parser.FlutterCompute*/)
abstract class UnsplashClient {

  factory UnsplashClient(Dio dio, {String? baseUrl}) = _UnsplashClient;

  @GET('search')
  Future<String> getPicture(
    @Query("name") String name,
    {
      @Query("count") int count = 5,
      @Header('Authorization') String clientId = 'Client-ID',
    }
  );

}