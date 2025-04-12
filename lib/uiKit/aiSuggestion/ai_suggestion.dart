import 'package:flutter/material.dart';

class AiSuggestion extends StatelessWidget {

  const AiSuggestion({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Pack an Umbrella!', style: Theme.of(context).textTheme.titleLarge),
            SizedBox(height: 8),
            Text('Suggestion bodySuggestion bodySuggestion bodySuggestion bodySuggestion bodySuggestion bodySuggestion body', style: Theme.of(context).textTheme.bodyMedium),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.gamepad),
                SizedBox(width: 8),
                Text('suggested by Gemini'),
              ],
            )
          ],
        ),
      ),
    );
  }
}