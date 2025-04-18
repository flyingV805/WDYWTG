import 'package:dio/dio.dart';
import 'package:wdywtg/features/featureFind/model/place_suggestion.dart';
import 'package:wdywtg/features/featureFind/repository/geocoding_repository.dart';

import '../../../core/log/loger.dart';
import '../../../core/openMeteo/open_geocode_client.dart';

class GeocodingRepositoryImpl extends GeocodingRepository {

  static final String _logTag = 'GeocodingRepositoryImpl';
  final _openGeocodeClient = OpenGeocodeClient(Dio());

  @override
  Future<List<PlaceSuggestion>> findSuggestions(String input) async {
    try{
      final result = _openGeocodeClient.getAutocomplete(input);
      return (await result).results.map(
        (item) => PlaceSuggestion(
          placeId: item.id,
          placeName: item.name,
          placeAdmin: item.generateAdminString(),
          placeCountryCode: item.countryCode,
          latitude: item.latitude,
          longitude: item.longitude,
          timezone: item.timezone
        )
      ).toList();
    }catch(e){
      Log().w(_logTag, e.toString());
      return [];
    }

  }

  @override
  void dispose() {}

}