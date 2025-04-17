import 'package:floor/floor.dart';
import 'package:wdywtg/core/database/dto/ai_advice_dto.dart';

@dao
abstract class AiAdviceDao {

  @Query('SELECT * FROM AiAdviceDto')
  Future<List<AiAdviceDto>> getAllAdvices();

  @Query('SELECT * FROM AiAdviceDto')
  Stream<List<AiAdviceDto>> allAdvicesLive();

  @insert
  Future<void> insertAdvice(AiAdviceDto advice);
  
}