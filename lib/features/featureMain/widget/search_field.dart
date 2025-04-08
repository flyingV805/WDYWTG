import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wdywtg/features/featureMain/bloc/main_bloc.dart';

class SearchField extends StatefulWidget {

  const SearchField({super.key});

  @override
  State<StatefulWidget> createState() => _SearchFieldState();

}

class _SearchFieldState extends State<SearchField>{

  final FocusNode _focusNode = FocusNode();

  bool _showSuggestionsList = false;

  @override
  void initState() {
    _focusNode.addListener(() {
      if (_focusNode.hasFocus){
        setState(() { _showSuggestionsList = true; });
      }else{
        setState(() { _showSuggestionsList = false; });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final searchSuggestions = context.select(
      (MainBloc bloc) => bloc.state.suggestions ?? [],
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
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
                  context.read<MainBloc>().add(UpdateSearch(searchable: searchable));
                },
                decoration: InputDecoration(
                  labelText: 'I\'m going to visit...',
                  errorText: null,
                  suffixIcon: IconButton(
                    onPressed: (){ _focusNode.unfocus(); },
                    icon: const Icon(Icons.close)
                  ),
                ),
              ),
              AnimatedSize(
                key: const Key('search_field_animated_size'),
                duration: const Duration(milliseconds: 250),
                child: SizedBox(
                  height: _showSuggestionsList ? 186 : 0,
                  child: Stack(
                    children: [
                      ListView.builder(
                        key: const Key('suggestions_list'),
                        itemCount: searchSuggestions.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            onTap: (){},
                            leading: CountryFlag.fromCountryCode(
                              'ES',
                              shape: const Circle(),
                            ),
                            title: Text(searchSuggestions[index].placeName),
                            subtitle: Text('Suggestion subtitle'),
                          );
                        }
                      ),
                      AnimatedOpacity(
                        key: const Key('search_field_animated_opacity'),
                        opacity: searchSuggestions.isEmpty ? 1 : 0,
                        duration: const Duration(milliseconds: 250),
                        child: Text('Nothing found...'),
                      )
                    ],
                  )/*AnimatedCrossFade(
                    duration: Duration(milliseconds: 250),
                    crossFadeState: searchSuggestions.isEmpty ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                    firstChild: Text('Nothing'),
                    secondChild: ListView.builder(
                      key: const Key('suggestions_list'),
                      itemCount: searchSuggestions.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text(searchSuggestions[index].placeName),
                        );
                      }
                    ),
                  ),*/
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}