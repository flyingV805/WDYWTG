import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

class WeatherRow extends StatelessWidget {

  const WeatherRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
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
              Text('0', style: Theme.of(context).textTheme.labelSmall,),
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
              Text('0', style: Theme.of(context).textTheme.labelSmall,),
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
              Text('0', style: Theme.of(context).textTheme.labelSmall,),
            ]
          )
        ),
      ],
    );
  }
}