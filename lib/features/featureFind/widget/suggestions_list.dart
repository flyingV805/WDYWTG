import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:wdywtg/features/featureFind/model/place_suggestion.dart';

import '../../../core/log/loger.dart';

class SuggestionsList extends StatefulWidget {

  final bool isExpanded;
  final List<PlaceSuggestion>? suggestions;
  final Function(PlaceSuggestion) onSelect;

  const SuggestionsList({
    super.key,
    required this.isExpanded,
    required this.suggestions,
    required this.onSelect,
  });

  @override
  State<StatefulWidget> createState() => _SuggestionsListState();

}

class _SuggestionsListState extends State<SuggestionsList> with TickerProviderStateMixin {

  static final String _logTag = '_SuggestionsListState';

  late final AnimationController _animationController = AnimationController(
    duration: const Duration(milliseconds: 250),
    vsync: this,
  );

  @override
  void initState() {
    if (widget.isExpanded) {
      _animationController.value = 1.0;
    }

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant SuggestionsList oldWidget) {
    super.didUpdateWidget(oldWidget);

    Log().d(_logTag, 'didUpdateWidget - isExpanded ${widget.isExpanded}');

    if(widget.isExpanded != oldWidget.isExpanded){
      if(widget.isExpanded){
        _animationController.forward();
      }else{
        _animationController.reverse();
      }
    }

  }

  Widget _buildWidget(BuildContext context, Widget? child) {
    return SizedBox(
      height: _animationController.value * 256,
      child: child,
    );
  }

  void _onSelected(PlaceSuggestion suggestion){
    widget.onSelect(suggestion);
  }

  @override
  Widget build(BuildContext context) {
    final bool isCollapsed = !widget.isExpanded && _animationController.isDismissed;

    final Widget result = Offstage(
      offstage: isCollapsed,
      child: TickerMode(
        enabled: !isCollapsed,
        child: Padding(
          padding: EdgeInsets.zero,
          child: AnimatedCrossFade(
            firstChild: Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                height: 256,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Lottie.asset(
                    'assets/lottie/not_found.json',
                    width: 160
                  ),
                ),
              ),
            ),
            secondChild: SizedBox(
              height: 256,
              child: ListView.builder(
                key: const Key('suggestions_list'),
                shrinkWrap: true,
                itemCount: widget.suggestions?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  final suggestion = widget.suggestions![index];
                  return ListTile(
                    onTap: (){ _onSelected(suggestion); },
                    leading: CountryFlag.fromCountryCode(
                      suggestion.placeCountryCode,
                      shape: const Circle(),
                    ),
                    title: Text(suggestion.placeName),
                    subtitle: Text(suggestion.placeAdmin),
                  );
                }
              ),
            ),
            crossFadeState: (widget.suggestions?.length ?? 0) > 0 ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            duration: Duration(milliseconds: 250)
          ),
        ),
      ),
    );

    return AnimatedBuilder(
      animation: _animationController.view,
      builder: _buildWidget,
      child: isCollapsed ? null : result,
    );
  }

}