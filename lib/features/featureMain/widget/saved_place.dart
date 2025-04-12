import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

const Duration _expandTime = Duration(milliseconds: 200);

class SavedPlace extends StatefulWidget {

  final double collapsedHeight;
  final bool initiallyExpanded;
  final bool maintainState;

  const SavedPlace({
    super.key,
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
                      child: Text('Berlin, DE', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: Colors.black)),
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
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.access_time_filled),
                              SizedBox(width: 4),
                              Text('14:05 (GMT +2)')
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Location weather
                  Padding(
                    padding: EdgeInsets.only(top: 68.0 + (128 * _heightFactor.value)),
                    child: SizedBox(
                      height: 60,
                      child: SizedBox(
                        width: double.infinity,
                        height: 60.0,
                        child: ClipRect(
                          child: BackdropFilter(
                            filter: ui.ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 2,
                                    child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [ Text('sdfsdfs') ]
                                    )
                                ),
                                VerticalDivider(width: 1, thickness: 1, color: Colors.grey.withAlpha(160),),
                                Expanded(
                                    flex: 1,
                                    child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text('WED', style: Theme.of(context).textTheme.labelSmall,),
                                          Icon(WeatherIcons.day_sunny, size: 16,),
                                          Text('${0}', style: Theme.of(context).textTheme.labelSmall,),
                                        ]
                                    )
                                ),
                                VerticalDivider(width: 1, thickness: 1, color: Colors.grey.withAlpha(160),),
                                Expanded(
                                    flex: 1,
                                    child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text('WED', style: Theme.of(context).textTheme.labelSmall,),
                                          Icon(WeatherIcons.day_sunny, size: 16,),
                                          Text('${0}', style: Theme.of(context).textTheme.labelSmall,),
                                        ]
                                    )
                                ),
                                VerticalDivider(width: 1, thickness: 1, color: Colors.grey.withAlpha(160),),
                                Expanded(
                                    flex: 1,
                                    child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text('WED', style: Theme.of(context).textTheme.labelSmall,),
                                          Icon(WeatherIcons.day_sunny, size: 16,),
                                          Text('${0}', style: Theme.of(context).textTheme.labelSmall,),
                                        ]
                                    )
                                ),
                                VerticalDivider(width: 1, thickness: 1, color: Colors.grey.withAlpha(160),),
                                Expanded(
                                    flex: 1,
                                    child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text('WED', style: Theme.of(context).textTheme.labelSmall,),
                                          Icon(WeatherIcons.day_sunny, size: 16,),
                                          Text('${0}', style: Theme.of(context).textTheme.labelSmall,),
                                        ]
                                    )
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
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
    return Column(
      children: [
        ListTile(
          onTap: _handleTap,
          title: Text('EXP TITLE'),
          leading: Icon(Icons.ac_unit_sharp),
          subtitle: Text('EXP SUBTITLE'),
        ),
      ]
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
            children: [
              Text('sdfsdfsdfsdfsdfsdf'),
              Text('sdfsdfsdfsdfsdfsdf'),
              Text('sdfsdfsdfsdfsdfsdf'),
              Text('sdfsdfsdfsdfsdfsdf'),
              Text('sdfsdfsdfsdfsdfsdf'),
              Text('sdfsdfsdfsdfsdfsdf'),
              Text('sdfsdfsdfsdfsdfsdf'),
              Text('sdfsdfsdfsdfsdfsdf'),
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
