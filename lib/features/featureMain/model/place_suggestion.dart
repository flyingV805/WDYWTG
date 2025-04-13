class PlaceSuggestion {

  final String placeName;
  final String placeCountryCode;

  PlaceSuggestion({
    required this.placeName,
    required this.placeCountryCode
  });

  PlaceSuggestion.exampleSuggestion() : this(
    placeName: 'Berlin',
    placeCountryCode: 'DE'
  );

}