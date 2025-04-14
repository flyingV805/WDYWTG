import 'package:json_annotation/json_annotation.dart';
part 'search_response.g.dart';

@JsonSerializable()
class SearchResponse {
  SearchResponse({
    required this.results,
  });

  factory SearchResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchResponseFromJson(json);

  @JsonKey(name: 'results')
  List<SearchResult> results;

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
    required this.timezone,
    required this.country,
    required this.admin1,
    required this.admin2,
    required this.admin3,
    required this.admin4,
  });

  factory SearchResult.fromJson(Map<String, dynamic> json) =>
      _$SearchResultFromJson(json);

  @JsonKey(name: 'id')
  int id;
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'latitude')
  double latitude;
  @JsonKey(name: 'longitude')
  double longitude;
  @JsonKey(name: 'country_code')
  String countryCode;
  @JsonKey(name: 'timezone')
  String timezone;
  @JsonKey(name: 'country')
  String country;

  @JsonKey(name: 'admin1')
  String? admin1;
  @JsonKey(name: 'admin2')
  String? admin2;
  @JsonKey(name: 'admin3')
  String? admin3;
  @JsonKey(name: 'admin4')
  String? admin4;

  String generateAdminString(){
    String buffer = '';

    if(admin4 != null) { buffer += '$admin4, '; }
    if(admin3 != null) { buffer += '$admin3, '; }
    if(admin2 != null) { buffer += '$admin2, '; }
    if(admin1 != null) { buffer += '$admin1, '; }
    buffer += country;

    return buffer;
  }

  Map<String, dynamic> toJson() => _$SearchResultToJson(this);
}
