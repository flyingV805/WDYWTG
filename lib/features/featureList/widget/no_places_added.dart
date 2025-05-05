import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoPlacesAdded extends StatelessWidget {

  const NoPlacesAdded({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
          child: Text(
            'Time to add a place! ',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        Lottie.asset(
          'assets/lottie/empty_list.json',
          width: 160
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
          child: Text(
            'The whole world is waiting for you! 😃',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        )
      ],
    );
  }



}