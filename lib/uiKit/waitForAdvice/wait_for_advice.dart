import 'dart:math';

import 'package:flutter/material.dart';

class WaitForAdvice extends StatefulWidget {

  const WaitForAdvice({super.key});

  @override
  State<StatefulWidget> createState() => _WaitForAdviceState();

}

final class _WaitForAdviceState extends State<WaitForAdvice>{

  String _waitForText = '';
  final List<String> _waitVariants = [
    'Hang tight — packing smart takes a second! 😃',
    'Just a sec… finding your perfect travel tips! ✈️',
    'Almost ready — checking the skies and customs! 🗺️',
    'Grabbing a scarf, umbrella, and some good advice... 🚀',
    'Hold on, consulting the travel gods... 🧭',
    'AI is thinking... and it’s a very polite traveler 💖',
    'Let me check with my weather-and-wisdom engine… ☁️',
    'Crunching clouds and customs, one moment! 🧭',
    'Your travel oracle is whispering... hold on! 🌴',
    'Checking if you’ll need sandals or snow boots! 🏔️🏖️',
    'One moment — making sure you won’t offend the locals! 🤔',
  ];

  @override
  void initState() {
    final randomIndex = Random().nextInt((_waitVariants.length - 1));
    _waitForText = _waitVariants[randomIndex];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        _waitForText,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }

}