import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wdywtg/di/app_di.dart';
import 'package:wdywtg/features/featureFind/repository/geocoding_repository.dart';
import 'package:wdywtg/features/featureList/repository/saved_places_repository.dart';
import 'package:wdywtg/screen/main_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'features/featureFind/repository/geocoding_repository_impl.dart';
import 'features/featureList/repository/saved_places_repository_impl.dart';
import 'features/featureUserLocation/repository/user_repository.dart';
import 'features/featureUserLocation/repository/user_repository_impl.dart';
import 'core/repositories/weather/weather_repository.dart';
import 'core/repositories/weather/weather_repository_impl.dart';

Future main() async {
  //debugRepaintRainbowEnabled = true;
  await dotenv.load(fileName: ".env");
  await initDI();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<WeatherRepository>(
          create: (_) => WeatherRepositoryImpl(),
          dispose: (repository) => repository.dispose(),
        ),
        RepositoryProvider<GeocodingRepository>(
          create: (_) => GeocodingRepositoryImpl(),
          dispose: (repository) => repository.dispose(),
        ),
        RepositoryProvider<UserRepository>(
          create: (_) => UserRepositoryImpl(),
          dispose: (repository) => repository.dispose(),
        ),
        RepositoryProvider<SavedPlacesRepository>(
          create: (_) => SavedPlacesRepositoryImpl(),
          dispose: (repository) => repository.dispose(),
        ),
        //RepositoryProvider(create: (_) => UserRepository()),
      ],
      child: MaterialApp(
        title: 'Where do you want to go today?',
        theme: ThemeData(
          brightness: Brightness.light,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple, brightness: Brightness.light),
          useMaterial3: true,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple, brightness: Brightness.dark),
          useMaterial3: true,
        ),
        home: MainScreen(),
      ),
    );
  }

}
