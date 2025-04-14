import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wdywtg/core/log/loger.dart';
import 'package:wdywtg/features/featureMain/widget/saved_places.dart';
import 'package:wdywtg/features/featureMain/widget/search_field.dart';

import 'bloc/main_bloc.dart';
import 'dialog/ask_for_location.dart';
import 'widget/user_location.dart';


class MainScreen extends StatelessWidget {

  static final String _logTag = 'MainScreen';

  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Where to?'),
        centerTitle: true,
      ),
      body: BlocListener<MainBloc, MainState>(
        listener: (context, state) {
          if(state.askForLocation) { askForLocationDialog(context); }
          Log().w(_logTag, state.toString());
        },
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              UserLocation(),
              SearchField(),
              SavedPlaces()
            ],
          ),
        ),
      ),
    );
  }



}