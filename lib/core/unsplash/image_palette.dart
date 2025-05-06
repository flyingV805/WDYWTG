import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:wdywtg/commonModel/place_picture_palette.dart';

import '../log/loger.dart';

final String _logTag = 'findTextPalette';

Future<PlacePicturePalette> findTextPalette(String imageUrl) async {

  final palette = await PaletteGenerator.fromImageProvider(NetworkImage(imageUrl));

  final luminance = palette.dominantColor?.color.computeLuminance();

  Log().w(_logTag, 'imageUrl - $imageUrl');
  Log().w(_logTag, 'luminance - $luminance');

  // 0.299*R + 0.587*G + 0.114*B
  PlacePicturePalette textColor = (luminance ?? 0) > 0.65 ?
    PlacePicturePalette.dark
      :
    PlacePicturePalette.light;

  return textColor;

}