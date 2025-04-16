import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:wdywtg/core/openCage/response/reverse_geocode_response.dart';

part 'open_cage_client.g.dart';

@RestApi(baseUrl: 'https://api.opencagedata.com/geocode/v1/', parser: Parser.FlutterCompute)
abstract class OpenCageClient {

  factory OpenCageClient(Dio dio, {String? baseUrl}) = _OpenCageClient;

  @GET('json')
  Future<ReverseGeocodeResponse> getAutocomplete(
    @Query("q") String query,
    @Query("key") String key
  );

}

FutureOr<ReverseGeocodeResponse> deserializeReverseGeocodeResponse(Map<String, dynamic> json) => ReverseGeocodeResponse.fromJson(json);
FutureOr<dynamic> serializeReverseGeocodeResponse(ReverseGeocodeResponse object) => object.toJson();