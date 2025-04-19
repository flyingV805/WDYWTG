import 'package:floor/floor.dart';

@entity
class AiAdviceDto {

  @PrimaryKey(autoGenerate: true)
  final int? id = null;
  final int placeId;
  final int generateDatetime;

  final String adviceTitle;
  final String content;

  AiAdviceDto(
    this.placeId, 
    this.generateDatetime,
    this.adviceTitle, 
    this.content
  );

}