class PlaceSuggestion {

  final int placeId;
  final String placeName;
  final String placeAdmin;
  final String placeCountryCode;
  final double latitude;
  final double longitude;
  final String timezone;

  PlaceSuggestion({
    required this.placeId,
    required this.placeName,
    required this.placeAdmin,
    required this.placeCountryCode,
    required this.latitude,
    required this.longitude,
    required this.timezone,
  });

  PlaceSuggestion.exampleSuggestion() : this(
    placeId: 7,
    placeName: 'Paris',
    placeAdmin: 'France',
    placeCountryCode: 'FR',
    latitude: 52.52437,
    longitude: 13.41053,
    timezone: 'Europe/Paris'
  );

}