sealed class PlaceSetupResponse {}

final class Success extends PlaceSetupResponse {}

final class FindPlaceError extends PlaceSetupResponse {}

final class WeatherError extends PlaceSetupResponse {}

final class ImageError extends PlaceSetupResponse {}