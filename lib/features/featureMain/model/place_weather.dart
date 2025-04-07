class PlaceWeather {

  final int currentCode;
  final int currentTemp;

  final int forecastDayOfWeek0;
  final int forecastCode0;
  final int forecastTemp0;

  final int forecastDayOfWeek1;
  final int forecastCode1;
  final int forecastTemp1;

  final int forecastDayOfWeek2;
  final int forecastCode2;
  final int forecastTemp2;

  final int forecastDayOfWeek3;
  final int forecastCode3;
  final int forecastTemp3;

  PlaceWeather({
    required this.currentCode,
    required this.currentTemp,

    required this.forecastDayOfWeek0,
    required this.forecastCode0,
    required this.forecastTemp0,

    required this.forecastDayOfWeek1,
    required this.forecastCode1,
    required this.forecastTemp1,

    required this.forecastDayOfWeek2,
    required this.forecastCode2,
    required this.forecastTemp2,

    required this.forecastDayOfWeek3,
    required this.forecastCode3,
    required this.forecastTemp3,
  });

  PlaceWeather.exampleWeather() : this(
    currentCode: 21,
    currentTemp: 21,
    forecastDayOfWeek0: 21,
    forecastCode0: 21,
    forecastTemp0: 21,
    forecastDayOfWeek1: 21,
    forecastCode1: 21,
    forecastTemp1: 21,
    forecastDayOfWeek2: 21,
    forecastCode2: 21,
    forecastTemp2: 21,
    forecastDayOfWeek3: 21,
    forecastCode3: 21,
    forecastTemp3: 21,
  );

}