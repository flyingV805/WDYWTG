import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:wdywtg/features/featureMain/model/place_profile.dart';
import 'package:wdywtg/uiKit/aiAdvice/ai_advice.dart';
import 'package:wdywtg/uiKit/tzTime/time_zoned_time.dart';
import 'package:wdywtg/uiKit/weatherRow/weather_row.dart';

const Duration _expandTime = Duration(milliseconds: 200);

class SavedPlace extends StatefulWidget {

  final PlaceProfile profile;
  final double collapsedHeight;
  final bool initiallyExpanded;
  final bool maintainState;

  const SavedPlace({
    super.key,
    required this.profile,
    this.collapsedHeight = 128,
    this.initiallyExpanded = false,
    this.maintainState = false
  });

  @override
  State<StatefulWidget> createState() => _SavedPlaceState();

}


class _SavedPlaceState extends State<SavedPlace> with SingleTickerProviderStateMixin {
  
  final Tween<double> _heightFactorTween = Tween<double>(begin: 0.0, end: 1.0);

  late AnimationController _animationController;
  late CurvedAnimation _heightFactor;

  bool _isExpanded = false;

  @override
  void initState() {

    _animationController = AnimationController(
      duration: _expandTime, 
      vsync: this
    );

    _heightFactor = CurvedAnimation(
      parent: _animationController.drive(_heightFactorTween),
      curve: Curves.easeIn,
    );

    _isExpanded = PageStorage.maybeOf(context)?.readState(context) as bool? ??
        widget.initiallyExpanded;

    if (_isExpanded) {
      _animationController.value = 1.0;
    }

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _heightFactor.dispose();
    super.dispose();
  }

  void _handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse().then<void>((void value) {
          if (!mounted) { return; }
          setState(() {});
        });
      }
      PageStorage.maybeOf(context)?.writeState(context, _isExpanded);
    });
    
  }

  Widget _buildWidget(BuildContext context, Widget? child) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: _handleTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          //clipper: ,
          child: Column(
            children: [
              Stack(
                children: [
                  // Location image
                  Align(
                    heightFactor: ui.clampDouble(0.5 + _heightFactor.value, .5, 1.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        'assets/image/florida.png',
                        width: double.infinity,
                        height: 256,
                        fit: BoxFit.fill
                      ),
                    ),
                  ),
                  // Location name
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        '${widget.profile.place.placeName}, ${widget.profile.place.placeCountryCode}',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: Colors.black)
                      ),
                    )
                  ),
                  // Location time
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(12), bottomLeft: Radius.circular(12))
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: TimeZonedTime(timeZone: 'GMT +2',),
                        ),
                      ),
                    ),
                  ),
                  // Location weather
                  Positioned(
                    bottom: 0,
                    height: 60,
                    left: 0,
                    right: 0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      child: BackdropFilter(
                        filter: ui.ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                        child: WeatherRow(weather: widget.profile.weather)
                      ),
                    )
                  )
                ],
              ),
              ClipRect(
                child: Align(
                  alignment: Alignment.center,
                  heightFactor: _heightFactor.value,
                  child: child,
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }

  @override
  Widget build(BuildContext context) {
    final bool closed = !_isExpanded && _animationController.isDismissed;
    final bool shouldRemoveChildren = closed && !widget.maintainState;

    final Widget result = Offstage(
      offstage: closed,
      child: TickerMode(
        enabled: !closed,
        child: Padding(
          padding: EdgeInsets.zero,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: widget.profile.advices.map(
              (element) => AiAdvice(advice: element)
            ).toList(growable: false),
          ),
        ),
      ),
    );

    return AnimatedBuilder(
      animation: _animationController.view,
      builder: _buildWidget,
      child: shouldRemoveChildren ? null : result,
    );
  }

}
