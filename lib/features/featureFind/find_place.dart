import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wdywtg/features/featureFind/bloc/find_bloc.dart';
import 'package:wdywtg/features/featureFind/dialog/advices_error_dialog.dart';
import 'package:wdywtg/features/featureFind/dialog/already_added_dialog.dart';
import 'package:wdywtg/features/featureFind/repository/add_place_repository.dart';
import 'package:wdywtg/features/featureFind/repository/geocoding_repository.dart';
import 'package:wdywtg/features/featureFind/widget/suggestions_list.dart';

import '../../core/log/loger.dart';
import 'dialog/image_error_dialog.dart';
import 'dialog/weather_error_dialog.dart';


final FocusNode _focusNode = FocusNode();
final TextEditingController _textController = TextEditingController();

class FindPlace extends StatelessWidget {

  static final String _logTag = 'FindPlace';

  const FindPlace({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (blocContext) => FindBloc(
        geocodingRepository: blocContext.read<GeocodingRepository>(),
        addRepository: blocContext.read<AddPlaceRepository>(),
        focusNode: _focusNode,
        fieldController: _textController
      ),
      child: BlocListener<FindBloc, FindState>(
        listener: (context, state){
          final error = state.error;
          Log().w(_logTag, 'BlocListener error - $error');
          switch(error){
            case AlreadyExistsError():
              AlreadyAddedDialog().show(context, error.place);
              break;
            case GetWeatherError():
              WeatherErrorDialog().show(context, error.place);
              break;
            case GetImageError():
              ImageErrorDialog().show(context, error.place);
              break;
            case GetAdvicesError():
              AdvicesErrorDialog().show(context, error.place);
              break;
            default: break;
          }
        },
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
                        controller: _textController,
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
                        onSelect: (suggestion){
                          context.read<FindBloc>().add(AddPlace(placeToAdd: suggestion));
                        },
                      )
                    ],
                  ),
                ),
              ),
            );
          }
        ),
      ),
    );
  }



}