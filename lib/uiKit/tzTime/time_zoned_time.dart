import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class TimeZonedTime extends StatefulWidget {

  final String timeZone;

  const TimeZonedTime({super.key, required this.timeZone});

  @override
  State<StatefulWidget> createState() => _TimeZonedTimeState();
  
}

class _TimeZonedTimeState extends State<TimeZonedTime> {

  late Timer _updateTimer;
  late tz.Location _location;
  late DateTime _currentTime;

  @override
  void initState() {
    super.initState();
    
    tz.initializeTimeZones();
    _location = tz.getLocation('Europe/Berlin');
    _currentTime = tz.TZDateTime.now(_location);

    _updateTimer = Timer.periodic(
      Duration(seconds: 15), 
      (_){ setState(() { _currentTime = tz.TZDateTime.now(_location);}); }
    );
  }

  @override
  void dispose() {
    _updateTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.access_time_filled),
        SizedBox(width: 4),
        Text('${DateFormat('HH:mm').format(_currentTime)} (${widget.timeZone})')
      ],
    );
  }
}