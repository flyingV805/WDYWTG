
import 'package:firebase_vertexai/firebase_vertexai.dart';
import 'package:wdywtg/core/database/dto/ai_advice_dto.dart';
import 'package:wdywtg/core/database/dto/saved_place_dto.dart';
import 'package:wdywtg/core/log/loger.dart';

class GeminiClient {

  static final String _logTag = 'GeminiClient';

  final model =
      FirebaseVertexAI.instance.generativeModel(model: 'gemini-2.0-flash');

  Future<List<AiAdviceDto>> generatePlaceAdvices(
    int placeId,
    String place,
    bool differentCountry
  ) async {

    List<AiAdviceDto> result = [];

    final clothesAdvice = await _clothesAdvice(placeId, place);
    result.add(clothesAdvice);

    if(differentCountry){

      final moneyAdvice = await _moneyAdvice(placeId, place);
      result.add(moneyAdvice);

      final culturalAdvice = await _culturalAdvice(placeId, place);
      result.add(culturalAdvice);

    }

    return result;
  }

  Future<AiAdviceDto> _clothesAdvice(int placeId, String place) async {
    final prompt = [
      Content.text('Write a short tip on what clothes to take with you to $place')
    ];

    final result = await model.generateContent(prompt);

    return AiAdviceDto(
      placeId,
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      'Clothes advice',
      (result.text ?? '').replaceAll('**', '').replaceAll('#', '')
    );
  }

  // create only if user country is different
  Future<AiAdviceDto> _moneyAdvice(int placeId, String place) async {
    final prompt = [
      Content.text('Write a super short advice on whether it is necessary to prepare money for a trip to $place')
    ];

    final result = await model.generateContent(prompt);

    return AiAdviceDto(
      placeId,
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      'Preparing money',
      (result.text ?? '').replaceAll('**', '').replaceAll('#', '')
    );
  }

  // create only if user country is different
  Future<AiAdviceDto> _culturalAdvice(int placeId, String place) async {
    final prompt = [
      Content.text('Write a short cultural tip for a trip to $place')
    ];

    final result = await model.generateContent(prompt);

    return AiAdviceDto(
      placeId,
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      'Cultural features',
      (result.text ?? '').replaceAll('**', '').replaceAll('#', '')
    );
  }

}