import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:wdywtg/core/unsplash/unsplash_client.dart';

import '../database/dto/saved_place_dto.dart';

class UnsplashResult {

  final String url;
  final String author;

  UnsplashResult({
    required this.url,
    required this.author
  });

}

class UnsplashWrapper {

  final _api = UnsplashClient(Dio());
  final unsplashApiKey = dotenv.get('UNSPLASH_API_ACCESS_KEY');

  Future<UnsplashResult?> getPlaceImage(SavedPlaceDto place) async {
    try {
      final response = await _api.getPicture(
        '${place.placeName} city, ${place.placeCountryCode}',
        unsplashApiKey
      );
      final url = response.results.firstOrNull?.urls.regular;
      final name = response.results.firstOrNull?.user.name;

      if (url == null) return null;
      if (name == null) return null;

      return UnsplashResult(
        url: url,
        author: name
      );
    } catch (e){
      return null;
    }

  }

}