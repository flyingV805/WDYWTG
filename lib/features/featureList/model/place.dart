class Place {

  final String placeName;
  final String placeTimezone;
  final String placeCountryCode;
  final String placePictureUrl;
  final double latitude;
  final double longitude;

  Place({
    required this.placeName,
    required this.placeTimezone,
    required this.placeCountryCode,
    required this.placePictureUrl,
    required this.latitude,
    required this.longitude,
  });
  
  Place.examplePlace() : this(
    placeName: 'Berlin',
    placeTimezone: 'Europe/Berlin',
    placeCountryCode: 'DE',
    placePictureUrl: 'https://example.com/berlin.jpg',
    latitude: 52.5200,
    longitude: 13.4050 
  );

}