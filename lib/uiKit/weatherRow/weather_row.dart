import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wdywtg/commonModel/place_weather.dart';
import 'weather_icon.dart';


final _rowDayFormat = DateFormat('EEE');

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
              SizedBox(width: 16,),
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
              Text(
                _rowDayFormat.format(DateTime.fromMillisecondsSinceEpoch(weather?.forecastDateTime0 ?? 0, isUtc: true)),
                style: Theme.of(context).textTheme.labelSmall,
              ),
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
              Text(
                _rowDayFormat.format(DateTime.fromMillisecondsSinceEpoch(weather?.forecastDateTime1 ?? 0, isUtc: true)),
                style: Theme.of(context).textTheme.labelSmall,
              ),
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
              Text(
                _rowDayFormat.format(DateTime.fromMillisecondsSinceEpoch(weather?.forecastDateTime2 ?? 0, isUtc: true)),
                style: Theme.of(context).textTheme.labelSmall,
              ),
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
              Text(
                _rowDayFormat.format(DateTime.fromMillisecondsSinceEpoch(weather?.forecastDateTime3 ?? 0, isUtc: true)),
                style: Theme.of(context).textTheme.labelSmall,
              ),
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