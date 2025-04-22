
import 'package:firebase_vertexai/firebase_vertexai.dart';
import 'package:wdywtg/core/database/dto/ai_advice_dto.dart';
import 'package:wdywtg/core/database/dto/saved_place_dto.dart';
import 'package:wdywtg/core/log/loger.dart';

class GeminiClient {

  static final String _logTag = 'GeminiClient';

  final model =
      FirebaseVertexAI.instance.generativeModel(model: 'gemini-2.0-flash');

  Future<List<AiAdviceDto>> generatePlaceAdvices(
    SavedPlaceDto place,
    bool includeMoney,
    bool includeCultural
  ) async {

    final prompt = [ 
      Content.text('Write a short tip on what clothes to take with you to ${place.placeName}, ${place.placeCountryCode}') 
    ];

    final result = await model.generateContent(prompt);

    final clothesAdvice = AiAdviceDto(
      place.id, 
      DateTime.now().millisecondsSinceEpoch ~/ 1000, 
      'Clothes advice', 
      (result.text ?? '').replaceAll('**', '')
    );

    Log().w(_logTag, 'generatePlaceAdvices - ${result.text}');

    return [clothesAdvice];
  }

  Future<AiAdviceDto> _clothesAdvice(SavedPlaceDto place) async {
    final prompt = [
      Content.text('Write a short tip on what clothes to take with you to ${place.placeName}, ${place.placeCountryCode}')
    ];

    final result = await model.generateContent(prompt);

    return AiAdviceDto(
        place.id,
        DateTime.now().millisecondsSinceEpoch ~/ 1000,
        'Clothes advice',
        (result.text ?? '').replaceAll('**', '')
    );
  }

  // create only if user country is different
  Future<AiAdviceDto> _moneyAdvice(SavedPlaceDto place) async {
    final prompt = [
      Content.text('Write a short tip on what clothes to take with you to ${place.placeName}, ${place.placeCountryCode}')
    ];

    final result = await model.generateContent(prompt);

    return AiAdviceDto(
        place.id,
        DateTime.now().millisecondsSinceEpoch ~/ 1000,
        'Clothes advice',
        (result.text ?? '').replaceAll('**', '')
    );
  }

  // create only if user country is different
  Future<AiAdviceDto> _culturalAdvice(SavedPlaceDto place) async {
    final prompt = [
      Content.text('Write a short tip on what clothes to take with you to ${place.placeName}, ${place.placeCountryCode}')
    ];

    final result = await model.generateContent(prompt);

    return AiAdviceDto(
        place.id,
        DateTime.now().millisecondsSinceEpoch ~/ 1000,
        'Clothes advice',
        (result.text ?? '').replaceAll('**', '')
    );
  }

}