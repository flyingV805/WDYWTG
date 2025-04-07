import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wdywtg/features/featureMain/bloc/main_bloc.dart';
import 'package:wdywtg/features/featureMain/repository/user/user_repository.dart';
import 'package:wdywtg/features/featureMain/repository/weather/weather_repository.dart';

import 'main_screen.dart';

class FeatureMain extends StatelessWidget {

  const FeatureMain({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const FeatureMain());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext blocContext) => MainBloc(
        weatherRepository: blocContext.read<WeatherRepository>(),
        userRepository: blocContext.read<UserRepository>()
      )..add(Initialize()),
      child: const MainScreen(),
    );
  }


}