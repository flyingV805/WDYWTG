import 'package:json_annotation/json_annotation.dart';
part 'unsplash_response.g.dart';

@JsonSerializable()
class UnsplashResponse {

  UnsplashResponse({
    required this.results,
  });

  @JsonKey(name: 'results') List<UnsplashResult> results;

  factory UnsplashResponse.fromJson(Map<String, dynamic> json) => _$UnsplashResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UnsplashResponseToJson(this);

}

@JsonSerializable()
class UnsplashResult {

  UnsplashResult({
    required this.urls,
    required this.user,
  });

  @JsonKey(name: 'urls') UnsplashUrls urls;
  @JsonKey(name: 'user') UnsplashUser user;

  factory UnsplashResult.fromJson(Map<String, dynamic> json) => _$UnsplashResultFromJson(json);
  Map<String, dynamic> toJson() => _$UnsplashResultToJson(this);

}

@JsonSerializable()
class UnsplashUrls {

  UnsplashUrls({
    required this.regular,
    required this.small,
    required this.thumb,
  });

  @JsonKey(name: 'regular') String regular;
  @JsonKey(name: 'small') String small;
  @JsonKey(name: 'thumb') String thumb;

  factory UnsplashUrls.fromJson(Map<String, dynamic> json) => _$UnsplashUrlsFromJson(json);
  Map<String, dynamic> toJson() => _$UnsplashUrlsToJson(this);

}

@JsonSerializable()
class UnsplashUser {

  UnsplashUser({
    required this.name,
    required this.username,
  });

  @JsonKey(name: 'name') String name;
  @JsonKey(name: 'username') String username;

  factory UnsplashUser.fromJson(Map<String, dynamic> json) => _$UnsplashUserFromJson(json);
  Map<String, dynamic> toJson() => _$UnsplashUserToJson(this);

}
