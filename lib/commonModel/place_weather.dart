class PlaceWeather {

  final int currentCode;
  final int currentTemp;

  final int forecastDateTime0;
  final int forecastCode0;
  final int forecastTempMin0;
  final int forecastTempMax0;

  final int forecastDateTime1;
  final int forecastCode1;
  final int forecastTempMin1;
  final int forecastTempMax1;

  final int forecastDateTime2;
  final int forecastCode2;
  final int forecastTempMin2;
  final int forecastTempMax2;

  final int forecastDateTime3;
  final int forecastCode3;
  final int forecastTempMin3;
  final int forecastTempMax3;

  PlaceWeather({
    required this.currentCode,
    required this.currentTemp,

    required this.forecastDateTime0,
    required this.forecastCode0,
    required this.forecastTempMin0,
    required this.forecastTempMax0,

    required this.forecastDateTime1,
    required this.forecastCode1,
    required this.forecastTempMin1,
    required this.forecastTempMax1,

    required this.forecastDateTime2,
    required this.forecastCode2,
    required this.forecastTempMin2,
    required this.forecastTempMax2,

    required this.forecastDateTime3,
    required this.forecastCode3,
    required this.forecastTempMin3,
    required this.forecastTempMax3,
  });

  PlaceWeather.exampleWeather() : this(
    currentCode: 0,
    currentTemp: 21,
    forecastDateTime0: 1,
    forecastCode0: 3,
    forecastTempMin0: 12,
    forecastTempMax0: 14,
    forecastDateTime1: 2,
    forecastCode1: 3,
    forecastTempMin1: 15,
    forecastTempMax1: 17,
    forecastDateTime2: 3,
    forecastCode2: 3,
    forecastTempMin2: 11,
    forecastTempMax2: 13,
    forecastDateTime3: 4,
    forecastCode3: 3,
    forecastTempMin3: 5,
    forecastTempMax3: 12,
  );

}