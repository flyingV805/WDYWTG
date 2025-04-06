import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/featureMain/feature_main.dart';
import 'features/featureMain/repository/user/user_repository.dart';
import 'features/featureMain/repository/user/user_repository_impl.dart';
import 'features/featureMain/repository/weather/weather_repository.dart';
import 'features/featureMain/repository/weather/weather_repository_impl.dart';

void main() {
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
        RepositoryProvider<UserRepository>(
          create: (_) => UserRepositoryImpl(),
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
        home: const FeatureMain(),
      ),
    );
  }

}
