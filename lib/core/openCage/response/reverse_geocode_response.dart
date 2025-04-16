import 'package:json_annotation/json_annotation.dart';
part 'reverse_geocode_response.g.dart';

@JsonSerializable()
class ReverseGeocodeResponse {

  ReverseGeocodeResponse({
    required this.results,
  });

  factory ReverseGeocodeResponse.fromJson(Map<String, dynamic> json) => _$ReverseGeocodeResponseFromJson(json);

  @JsonKey(name: 'results') List<GeocodeResult> results;

  Map<String, dynamic> toJson() => _$ReverseGeocodeResponseToJson(this);

}

@JsonSerializable()
class GeocodeResult {

  GeocodeResult({
    required this.component,
  });

  factory GeocodeResult.fromJson(Map<String, dynamic> json) => _$GeocodeResultFromJson(json);

  @JsonKey(name: 'components') ResultComponent component;

  Map<String, dynamic> toJson() => _$GeocodeResultToJson(this);

}

@JsonSerializable()
class ResultComponent {

  ResultComponent({
    required this.city,
    required this.country,
    required this.countryCode,
    required this.state
  });

  factory ResultComponent.fromJson(Map<String, dynamic> json) => _$ResultComponentFromJson(json);

  @JsonKey(name: 'city') String city;
  @JsonKey(name: 'country') String country;
  @JsonKey(name: 'country_code') String countryCode;
  @JsonKey(name: 'state') String state;

  Map<String, dynamic> toJson() => _$ResultComponentToJson(this);

}