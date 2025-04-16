import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wdywtg/features/featureList/bloc/list_bloc.dart';
import 'package:wdywtg/features/featureList/widget/no_places_added.dart';
import 'package:wdywtg/features/featureList/widget/saved_place.dart';

class PlacesList extends StatelessWidget {

  const PlacesList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (blocContext) => ListBloc()..add(Initialize()),
      child: BlocBuilder<ListBloc, ListState>(
        builder: (context, state) => AnimatedCrossFade(
          firstChild: NoPlacesAdded(),
          secondChild: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: state.places?.length ?? 0,
            itemBuilder: (BuildContext context, int index) {
              final item = state.places![index];
              return SavedPlace(
                key: ValueKey(item.place.placeName),
                profile: item
              );
            }
          ),
          crossFadeState: state.noSavedPlaces ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          duration: const Duration(milliseconds: 250)
        )
      ),
    );
  }



}