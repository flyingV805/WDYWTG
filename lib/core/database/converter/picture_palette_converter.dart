import 'package:floor/floor.dart';
import 'package:wdywtg/commonModel/place_picture_palette.dart';

class PicturePaletteConverter extends TypeConverter<PlacePicturePalette, int> {

  @override
  PlacePicturePalette decode(int databaseValue) {
    return PlacePicturePalette.values[databaseValue];
  }

  @override
  int encode(PlacePicturePalette value) {
    return value.index;
  }

}