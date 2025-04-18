sealed class AddResult {}

final class Success extends AddResult {}

final class AlreadyAddedError extends AddResult {}

final class WeatherError extends AddResult {}