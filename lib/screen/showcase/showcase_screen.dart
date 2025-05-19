import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:wdywtg/commonModel/place_weather.dart';
import 'package:wdywtg/features/featureFind/model/place_suggestion.dart';
import 'package:wdywtg/features/featureList/model/place_profile.dart';
import '../../features/featureFind/widget/suggestions_list.dart';
import '../../features/featureList/model/place.dart';
import '../../features/featureList/model/place_advice.dart';
import '../../features/featureList/widget/saved_place.dart';
import '../../uiKit/whereToText/where_to_text.dart';

class ShowcaseScreen extends StatefulWidget {

  final bool ulEnabled;
  final Function() onFinished;

  const ShowcaseScreen({
    super.key,
    required this.ulEnabled,
    required this.onFinished,
  });

  @override
  State<StatefulWidget> createState() => _ShowcaseScreenState();

}

final class _ShowcaseScreenState extends State<ShowcaseScreen> {

  final TextEditingController _textController = TextEditingController();
  bool _showList = false;
  bool _expandList = false;
  bool _showPlace = false;
  final List<PlaceSuggestion> _suggestions = [ PlaceSuggestion.exampleSuggestion() ];

  BuildContext? _showcaseContext;
  final GlobalKey _userLocation0 = GlobalKey();
  final GlobalKey _findPlace1 = GlobalKey();
  final GlobalKey _searchField2 = GlobalKey();
  final GlobalKey _foundPlace3 = GlobalKey();
  final GlobalKey _placeAdded4 = GlobalKey();
  final GlobalKey _collapsePlace5 = GlobalKey();

  @override
  void initState() {

    WidgetsBinding.instance.addPostFrameCallback((duration){
      Future.delayed(
        Duration(milliseconds: 550),
        (){
          if(_showcaseContext != null){
            if(widget.ulEnabled) {
              ShowCaseWidget.of(_showcaseContext!).startShowCase([
                _userLocation0, _findPlace1, _searchField2, _foundPlace3, _placeAdded4, _collapsePlace5
              ]);
            } else {
              ShowCaseWidget.of(_showcaseContext!).startShowCase([
                _findPlace1, _searchField2, _foundPlace3, _placeAdded4, _collapsePlace5
              ]);
            }
          }
        }
      );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ShowCaseWidget(
      builder: (context) {
        _showcaseContext = context;
        return Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Showcase(
                key: _userLocation0,
                title: 'User location',
                description: 'Here you can find your current location. With weather!',
                child: SizedBox(width: double.infinity, height: 186)
              )
            ),
            Padding(
              padding: const EdgeInsets.only(top: 218, left: 8, right: 8),
              child: ColoredBox(
                color: Theme.of(context).colorScheme.surface,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch ,
                  children: [
                    WhereToText(),
                    SizedBox(height: 8),
                    Showcase(
                      key: _findPlace1,
                      title: 'Find a place',
                      description: 'Find a place for your trip by entering its name',
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Showcase(
                                key: _searchField2,
                                title: 'Search for a place',
                                description: 'After entering the name, the application will find what you are looking for.',
                                child: TextField(
                                  key: const Key('place_search_field'),
                                  readOnly: true,
                                  controller: _textController,
                                  textInputAction: TextInputAction.none,
                                  decoration: InputDecoration(
                                    labelText: 'I\'m going to visit...',
                                    errorText: null,
                                    suffixIcon: AnimatedOpacity(
                                      opacity: _showList ? 1 : 0,
                                      duration: const Duration(milliseconds: 250),
                                      child: const Icon(Icons.close),
                                    ),
                                    prefixIcon: Icon(key: ValueKey('searched'), Icons.search)
                                  ),
                                ),
                              ),
                              Showcase(
                                key: _foundPlace3,
                                title: 'Add a place',
                                description: 'Add a place to your list by simply tapping on it.',
                                child: SuggestionsList(
                                  isExpanded: _expandList,
                                  suggestions: _suggestions,
                                  onSelect: (suggestion){},
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),

                    if(_showPlace) Expanded(
                      child: Showcase(
                        key: _placeAdded4,
                        title: 'Here is your place!',
                        description: 'Now you know what to prepare for! City view, weather and tips for a comfortable trip are here!',
                        child: Showcase(
                          key: _collapsePlace5,
                          title: 'Collapse/Expand',
                          description: 'If you are traveling to several places, it is convenient to see the weather and time in several places if you collapse/expand information about a place by simply tapping on the picture of the place.',
                          child: SavedPlace(
                            initiallyExpanded: true,
                            profile: PlaceProfile(
                              place: Place.examplePlace(),
                              advicesAvailable: true,
                              weather: PlaceWeather.exampleWeather(),
                              advices: [ PlaceAdvice.exampleAdvice() ]
                            ),
                          )
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ),
          ],
        );
      },
      onFinish: (){ widget.onFinished(); },
      onComplete: (index, key){

        if(key == _findPlace1){
          _textController.text = 'Paris';
          setState(() { _expandList = false; _showList = false; });
          Future.delayed(Duration(milliseconds: 350), (){ setState(() {}); });
        }

        if(key == _searchField2){
          setState(() { _expandList = true; _showList = true; });
          Future.delayed(Duration(milliseconds: 350), (){ setState(() {}); });
        }

        if(key == _foundPlace3){
          _textController.text = '';
          setState(() { _expandList = false; _showList = false; _showPlace = true;});
          Future.delayed(Duration(milliseconds: 250), (){ setState(() {}); });
        }

/*
        if(key == _findPlace1){
          setState(() { _expandList = true; _showList = true; });
          Future.delayed(Duration(milliseconds: 350), (){ setState(() {}); });
        }
*/
/*
        if(key == _foundPlace){
          _textController.text = '';
          setState(() { _expandList = false; _showList = false; _showPlace = true;});
          Future.delayed(Duration(milliseconds: 350), (){ setState(() {}); });
        }*/
      },
    );
  }

}