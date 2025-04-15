import 'package:flutter/material.dart';

class Preloader extends StatelessWidget {

  const Preloader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('user_weather_preload_widget'),
      color: Colors.red,
    );
  }

}