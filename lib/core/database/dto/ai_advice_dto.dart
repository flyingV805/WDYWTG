import 'package:floor/floor.dart';

@entity
class AiAdviceDto {

  @PrimaryKey(autoGenerate: true)
  final int id;
  final int placeId;

  final String adviceTitle;
  final String content;

  AiAdviceDto(
    this.id,
    this.placeId, 
    this.adviceTitle, 
    this.content
  );

}