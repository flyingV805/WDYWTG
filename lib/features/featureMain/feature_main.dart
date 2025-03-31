import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wdywtg/features/featureMain/bloc/main_bloc.dart';

import 'main_screen.dart';

class FeatureMain extends StatelessWidget {

  const FeatureMain({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const FeatureMain());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => MainBloc()..add(Initialize()),
      child: const MainScreen(),
    );
  }


}