import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:wdywtg/commonModel/place_picture_palette.dart';

Future<PlacePicturePalette> findTextPalette(String imageUrl) async {

  final palette = await PaletteGenerator.fromImageProvider(NetworkImage(imageUrl));

  // 0.299*R + 0.587*G + 0.114*B
  final textColor = ThemeData.estimateBrightnessForColor(palette.dominantColor?.color ?? Colors.white);

  return switch(textColor){
    Brightness.dark => PlacePicturePalette.dark,
    Brightness.light => PlacePicturePalette.light,
  };

}