import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wdywtg/features/featureList/bloc/list_bloc.dart';
import 'package:wdywtg/features/featureList/repository/saved_places_repository.dart';
import 'package:wdywtg/features/featureList/widget/no_places_added.dart';
import 'package:wdywtg/features/featureList/widget/saved_place.dart';

class PlacesList extends StatelessWidget {

  const PlacesList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (blocContext) => ListBloc(
        placesRepository: blocContext.read<SavedPlacesRepository>(),
      )..add(Initialize()),
      child: BlocBuilder<ListBloc, ListState>(
        builder: (context, state) {
          final bool isEmpty = state.noSavedPlaces;
          return SliverList.list(
            children: [
              AnimatedSwitcher(
                key: ValueKey('AnimatedSwitcher'),
                duration: Duration(milliseconds: 250),
                child: isEmpty ? NoPlacesAdded(key: ValueKey('NoPlacesAdded')) : SizedBox.shrink(key: ValueKey('placeHolder'),),
              ),
              ...?
                state.places?.map((item) => SavedPlace(
                  key: PageStorageKey(item.place.placeName),
                  initiallyExpanded: item.place.lastAdded || state.places!.length == 1,
                  profile: item
                ))
            ]
          );
        },
      ),
    );
  }

}