import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';

part 'open_meteo_client.g.dart';

@RestApi(baseUrl: 'https://api.open-meteo.com/v1/forecast')
abstract class OpenMeteoClient {

  factory OpenMeteoClient(Dio dio, {String? baseUrl}) = _OpenMeteoClient;

}