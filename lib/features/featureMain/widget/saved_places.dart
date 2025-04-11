import 'package:flutter/material.dart';
import 'package:wdywtg/features/featureMain/widget/saved_place.dart';

class SavedPlaces extends StatelessWidget {
  const SavedPlaces({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemCount: 3,
      itemBuilder: (BuildContext context, int index) {
        return SavedPlace();
      },
      separatorBuilder: (_, __) => const SizedBox(height: 8),
    );
  }
}
