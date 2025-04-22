sealed class AddResult {}

final class Success extends AddResult {}

final class AlreadyAddedError extends AddResult {}

final class WeatherError extends AddResult {}

final class ImageError extends AddResult {}

final class AdvicesError extends AddResult {}