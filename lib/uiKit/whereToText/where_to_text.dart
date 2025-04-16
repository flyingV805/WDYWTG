import 'dart:math';

import 'package:flutter/material.dart';

class WhereToText extends StatefulWidget {

  const WhereToText({super.key});

  @override
  State<StatefulWidget> createState() => _WhereToTextState();

}

class _WhereToTextState extends State<WhereToText>{

  String _questionText = '';
  final List<String> _questions = [
    'So, where to this time? 😃',
    'Where’s your next adventure? 🌟',
    'Got a place in mind? 🗺️',
    'Planning a getaway, are we? ✈️',
    'Where do your dreams take you today? ☁️',
    'Destination: Unknown... or not? 🧭',
    'New trip, new memories — where to? 📸',
    'Fancy going somewhere fun? 🎒',
    'Time to pack your bags — but where to?',
    'Where’s the compass pointing today? 🧭',
    'Let’s pick a place to wander! 🌍',
    'Just say the word — and we’re off! 🚀',
    'Your next stop is... ? 😏',
    'Got travel on your mind? Let’s go! 🌴',
    'Craving mountains or beaches today? 🏔️🏖️',
    'Where would you rather be right now? 🤔',
    'Dreaming of somewhere new? ✨',
    'Let’s find your next favorite place 💖',
    'One ticket to...? 🎟️',
  ];

  @override
  void initState() {
    final randomIndex = Random().nextInt((_questions.length - 1));
    _questionText = _questions[randomIndex];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        _questionText,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }



}