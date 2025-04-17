import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wdywtg/features/featureFind/bloc/find_bloc.dart';
import 'package:wdywtg/features/featureFind/repository/add_place_repository.dart';
import 'package:wdywtg/features/featureFind/repository/geocoding_repository.dart';
import 'package:wdywtg/features/featureFind/widget/suggestions_list.dart';


final FocusNode _focusNode = FocusNode();

class FindPlace extends StatelessWidget {

  const FindPlace({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (blocContext) => FindBloc(
        geocodingRepository: blocContext.read<GeocodingRepository>(),
        addRepository: blocContext.read<AddPlaceRepository>(),
        focusNode: _focusNode
      )..add(Initialize()),
      child: BlocBuilder<FindBloc, FindState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      key: const Key('place_search_field'),
                      focusNode: _focusNode,
                      onChanged: (searchable) {
                        context.read<FindBloc>().add(UpdateSearch(searchable: searchable));
                      },
                      decoration: InputDecoration(
                        labelText: 'I\'m going to visit...',
                        errorText: null,
                        suffixIcon: AnimatedOpacity(
                          opacity: state.showList ? 1 : 0,
                          duration: const Duration(milliseconds: 250),
                          child: IconButton(
                            onPressed: (){ _focusNode.unfocus(); },
                            icon: const Icon(Icons.close)
                          ),
                        ),
                      ),
                    ),
                    SuggestionsList(
                      isExpanded: state.showList,
                      suggestions: state.suggestions,
                    )
                  ],
                ),
              ),
            ),
          );
        }
      )
    );
  }



}