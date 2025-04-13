import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wdywtg/features/featureMain/widget/saved_place.dart';

import '../bloc/main_bloc.dart';
import '../model/place_profile.dart';

class SavedPlaces extends StatelessWidget {

  const SavedPlaces({super.key});

  @override
  Widget build(BuildContext context) {
    final savedPlaces = context.select(
      (MainBloc bloc) => bloc.state.savedPlaces ?? [],
    );
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemCount: savedPlaces.length,
      itemBuilder: (BuildContext context, int index) {
        return SavedPlace(
          profile: savedPlaces[index],
          initiallyExpanded: savedPlaces.length == 1,
        );
      },
      separatorBuilder: (_, __) => const SizedBox(height: 8),
    );
  }
}
