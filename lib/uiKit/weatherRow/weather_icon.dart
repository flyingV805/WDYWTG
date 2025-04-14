import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

class OpenMeteoWeatherIcon {

  static IconData fromCode(int? weatherCode){
    return switch(weatherCode){
      0 => WeatherIcons.day_sunny,
      1 => WeatherIcons.day_sunny ,
      2 => WeatherIcons.cloudy,
      3 => WeatherIcons.day_sunny_overcast,
      45 => WeatherIcons.fog,
      48 => WeatherIcons.fog,
      /*51 => WeatherIcons.DrizzleLight,
      53 => WeatherIcons.DrizzleModerate,
      55 => WeatherIcons.DrizzleDense,
      56 => WeatherIcons.FreezingDrizzleLight,
      57 => WeatherIcons.FreezingDrizzleDense,
      61 => WeatherIcons.day_rain,
      63 => WeatherIcons.RainModerate,
      65 => WeatherIcons.RainHeavy,
      66 => WeatherIcons.FreezingRainLight,
      67 => WeatherIcons.FreezingRainHeavy,
      71 => WeatherIcons.SnowFallSlight,
      73 => WeatherIcons.SnowFallModerate,
      75 => WeatherIcons.SnowFallHeavy,
      77 => WeatherIcons.SnowGrain,
      80 => WeatherIcons.RainShowerSlight,
      81 => WeatherIcons.RainShowerModerate,
      82 => WeatherIcons.RainShowerViolent,
      85 => WeatherIcons.SnowShowerSlight,
      86 => WeatherIcons.SnowShowerHeavy,
      95 => WeatherIcons.ThunderstormSlight,
      96 => WeatherIcons.ThunderStormSlightHail,
      99 => WeatherIcons.ThunderStormHeavyHail,*/
        _ => WeatherIcons.day_sunny,
    };
  }

}