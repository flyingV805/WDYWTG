import 'package:flutter/material.dart';
import 'package:wdywtg/features/featureList/model/place_advice.dart';

class AiAdvice extends StatelessWidget {

  final PlaceAdvice advice;

  const AiAdvice({super.key, required this.advice});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(advice.adviceTitle, style: Theme.of(context).textTheme.titleLarge),
            SizedBox(height: 8),
            Text(advice.adviceBody, style: Theme.of(context).textTheme.bodyMedium),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('suggested by', style: Theme.of(context).textTheme.labelSmall),
                SizedBox(width: 5),
                Image.asset('assets/image/gemini.png', height: 24),
              ],
            )
          ],
        ),
      ),
    );
  }
}