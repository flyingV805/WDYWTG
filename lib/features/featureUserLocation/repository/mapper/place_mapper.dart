import 'package:wdywtg/core/database/dto/saved_place_dto.dart';

import '../../../../core/database/constants.dart';
import '../../../../core/openCage/response/reverse_geocode_response.dart';

SavedPlaceDto mapFromGeocode(GeocodeResult geocode, double latitude, double longitude){
  return SavedPlaceDto(
    Constants.userPlaceId,
    geocode.component.city,
    '',
    geocode.component.countryCode.toUpperCase(),
    null,
    null,
    null,
    latitude,
    longitude,
    false,
    0
  );
}