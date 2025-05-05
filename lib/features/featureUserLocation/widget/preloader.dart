import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Preloader extends StatelessWidget {

  const Preloader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('user_weather_preload_widget'),
      alignment: Alignment.center,
      child: Lottie.asset(
        'assets/lottie/not_found.json',
        width: 160
      ),
    );
  }

}