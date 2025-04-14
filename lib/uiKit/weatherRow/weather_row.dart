import 'package:flutter/material.dart';
import 'package:wdywtg/features/featureMain/model/place_weather.dart';
import 'package:weather_icons/weather_icons.dart';
import 'weather_icon.dart';

class WeatherRow extends StatelessWidget {

  final PlaceWeather? weather;

  const WeatherRow({
    super.key,
    required this.weather
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(OpenMeteoWeatherIcon.fromCode(weather?.currentCode), size: 24,),
              SizedBox(width: 8,),
              Text('${weather?.currentTemp ?? '-'}°', style: Theme.of(context).textTheme.titleLarge,),
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
              Icon(OpenMeteoWeatherIcon.fromCode(weather?.forecastCode0), size: 16,),
              Text(
                '${weather?.forecastTempMin0 ?? '-'}° / ${weather?.forecastTempMax0 ?? '-'}°',
                style: Theme.of(context).textTheme.labelSmall,
              ),
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
              Icon(OpenMeteoWeatherIcon.fromCode(weather?.forecastCode1), size: 16,),
              Text(
                '${weather?.forecastTempMin1 ?? '-'}° / ${weather?.forecastTempMax1 ?? '-'}°',
                style: Theme.of(context).textTheme.labelSmall,
              ),
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
              Icon(OpenMeteoWeatherIcon.fromCode(weather?.forecastCode2), size: 16,),
              Text(
                '${weather?.forecastTempMin2 ?? '-'}° / ${weather?.forecastTempMax2 ?? '-'}°',
                style: Theme.of(context).textTheme.labelSmall,
              ),
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
              Icon(OpenMeteoWeatherIcon.fromCode(weather?.forecastCode3), size: 16,),
              Text(
                '${weather?.forecastTempMin3 ?? '-'}° / ${weather?.forecastTempMax3 ?? '-'}°',
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ]
          )
        ),
      ],
    );
  }
}