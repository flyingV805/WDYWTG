class PlaceSuggestion {

  final String placeName;
  final String placeAdmin;
  final String placeCountryCode;
  final double latitude;
  final double longitude;
  final String timezone;

  PlaceSuggestion({
    required this.placeName,
    required this.placeAdmin,
    required this.placeCountryCode,
    required this.latitude,
    required this.longitude,
    required this.timezone,
  });

  PlaceSuggestion.exampleSuggestion() : this(
    placeName: 'Berlin',
    placeAdmin: 'Germany',
    placeCountryCode: 'DE',
    latitude: 52.52437,
    longitude: 13.41053,
    timezone: 'Europe/Berlin'
  );

}