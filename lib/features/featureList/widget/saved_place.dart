import 'dart:ui' as ui;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wdywtg/uiKit/aiAdvice/ai_advice.dart';
import 'package:wdywtg/uiKit/tzTime/time_zoned_time.dart';
import 'package:wdywtg/uiKit/weatherRow/weather_row.dart';

import '../../../core/log/loger.dart';
import '../../../uiKit/animatedColorText/animated_color_text.dart';
import '../model/place_profile.dart';
import '../../../uiKit/cityImagePlaceholder/image_placeholder.dart';

const Duration _expandTime = Duration(milliseconds: 200);

class SavedPlace extends StatefulWidget {

  final PlaceProfile profile;
  final bool initiallyExpanded;
  final bool maintainState;

  const SavedPlace({
    super.key,
    required this.profile,
    this.initiallyExpanded = false,
    this.maintainState = false
  });

  @override
  State<StatefulWidget> createState() => _SavedPlaceState();

}


class _SavedPlaceState extends State<SavedPlace> with SingleTickerProviderStateMixin {

  static final String _logTag = '_SavedPlaceState';

  final Tween<double> _heightFactorTween = Tween<double>(begin: 0.0, end: 1.0);

  late AnimationController _animationController;
  late CurvedAnimation _heightFactor;

  bool _isExpanded = false;

  @override
  void initState() {

    Log().w(_logTag, 'initState');

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
                    heightFactor: ui.clampDouble(0.7 + _heightFactor.value, .8, 1.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CachedNetworkImage(
                        imageUrl: widget.profile.place.placePictureUrl,
                        width: double.infinity,
                        height: 186,
                        fit: BoxFit.fill,
                        placeholder: (context, url) => ImagePlaceholder(),
                        errorWidget: (context, url, error) => ImagePlaceholder(),
                      )
                    ),
                  ),
                  // Location name
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AnimatedColorText(
                            text: '${widget.profile.place.placeName}, ${widget.profile.place.placeCountryCode}',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                            palette: widget.profile.place.placePicturePalette,
                          ),
                          AnimatedColorText(
                            text: widget.profile.place.placePictureAuthor.isEmpty ? '' : 'Photo by ${widget.profile.place.placePictureAuthor} (Unsplash)',
                            style: Theme.of(context).textTheme.labelSmall,
                            palette: widget.profile.place.placePicturePalette,
                          )
                        ],
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
                          child: TimeZonedTime(timeZone: widget.profile.place.placeTimezone,),
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
    final bool showAdvicesLoading = widget.profile.advices.isEmpty;

    final Widget result = Offstage(
      offstage: closed,
      child: TickerMode(
        enabled: !closed,
        child: Padding(
          padding: EdgeInsets.zero,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if(showAdvicesLoading) SizedBox(height: 16),
              if(showAdvicesLoading) SizedBox(
                width: 36,
                height: 36,
                child: CircularProgressIndicator()
              ),
              if(showAdvicesLoading) Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Your travel oracle is whispering... hold on! 🤖',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              ...widget.profile.advices.map(
                (element) => AiAdvice(advice: element)
              )
            ],
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
