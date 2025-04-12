import 'package:wdywtg/features/featureMain/model/place.dart';
import 'package:wdywtg/features/featureMain/model/place_suggestion.dart';
import 'package:wdywtg/features/featureMain/model/place_weather.dart';

class PlaceProfile {

  final Place place;
  final PlaceWeather? weather;
  final List<PlaceSuggestion> suggestions;

  const PlaceProfile({
    required this.place,
    this.weather,
    this.suggestions = const []
  });

}