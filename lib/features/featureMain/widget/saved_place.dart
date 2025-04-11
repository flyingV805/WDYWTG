import 'package:flutter/material.dart';

const Duration _expandTime = Duration(milliseconds: 200);

class SavedPlace extends StatefulWidget {
  final bool initiallyExpanded;
  final bool maintainState;

  const SavedPlace(
      {super.key, this.initiallyExpanded = false, this.maintainState = false});

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
          if (!mounted) {
            return;
          }
          setState(() {});
        });
      }
      PageStorage.maybeOf(context)?.writeState(context, _isExpanded);
    });
    
  }

  Widget _buildHeader(BuildContext context, Widget? child) {
    return Column(children: [
      ListTile(
        onTap: _handleTap,
        title: Text('EXP TITLE'),
        leading: Icon(Icons.ac_unit_sharp),
        subtitle: Text('EXP SUBTITLE'),
      ),
      ClipRect(
        child: Align(
          alignment: Alignment.center,
          heightFactor: _heightFactor.value,
          child: child,
        ),
      ),
    ]);
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
      builder: _buildHeader,
      child: shouldRemoveChildren ? null : result,
    );
  }

}
