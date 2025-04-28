import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:wdywtg/commonModel/place_picture_palette.dart';

Future<PlacePicturePalette> findTextPalette(String imageUrl) async {

  final palette = await PaletteGenerator.fromImageProvider(NetworkImage(imageUrl));
  final textColor = ThemeData.estimateBrightnessForColor(palette.dominantColor?.color ?? Colors.white);

  return switch(textColor){
    Brightness.dark => PlacePicturePalette.dark,
    Brightness.light => PlacePicturePalette.light,
  };

}