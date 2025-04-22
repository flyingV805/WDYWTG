import 'package:flutter/material.dart';

class ImagePlaceholder extends StatelessWidget {

  const ImagePlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/image/city_placeholder.jpg',
      width: double.infinity,
      height: 186,
      fit: BoxFit.fill
    );
  }

}