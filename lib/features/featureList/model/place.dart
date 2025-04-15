class Place {

  final String placeName;
  final String placeTimezone;
  final String placeCountryCode;
  final String placePictureUrl;

  Place({
    required this.placeName,
    required this.placeTimezone,
    required this.placeCountryCode,
    required this.placePictureUrl,
  });
  
  Place.examplePlace() : this(
    placeName: 'Berlin',
    placeTimezone: 'Europe/Berlin',
    placeCountryCode: 'DE',
    placePictureUrl: 'https://example.com/berlin.jpg',
  );

}