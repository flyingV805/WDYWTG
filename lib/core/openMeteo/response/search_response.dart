import 'package:json_annotation/json_annotation.dart';
part 'search_response.g.dart';

@JsonSerializable()
class SearchResponse {

  SearchResponse({
    required this.results,
  });

  factory SearchResponse.fromJson(Map<String, dynamic> json) => _$SearchResponseFromJson(json);

  @JsonKey(name: 'results') List<SearchResult> results;

  Map<String, dynamic> toJson() => _$SearchResponseToJson(this);

}

@JsonSerializable()
class SearchResult {

  SearchResult({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.countryCode,
    required this.country,
  });

  factory SearchResult.fromJson(Map<String, dynamic> json) => _$SearchResultFromJson(json);

  @JsonKey(name: 'id') int id;
  @JsonKey(name: 'name') String name;
  @JsonKey(name: 'latitude') double latitude;
  @JsonKey(name: 'longitude') double longitude;
  @JsonKey(name: 'country_code') String countryCode;
  @JsonKey(name: 'country') String country;

  Map<String, dynamic> toJson() => _$SearchResultToJson(this);

}