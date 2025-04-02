import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';

part 'open_meteo_client.g.dart';

@RestApi(baseUrl: 'https://5d42a6e2bc64f90014a56ca0.mockapi.io/api/v1/')
abstract class OpenMeteoClient {

  factory OpenMeteoClient(Dio dio, {String? baseUrl}) = _OpenMeteoClient;

}