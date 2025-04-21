import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../features/featureFind/find_place.dart';
import '../features/featureList/places_list.dart';
import '../features/featureUpdater/info_updater.dart';
import '../features/featureUserLocation/user_location.dart';
import '../uiKit/whereToText/where_to_text.dart';

class MainScreen extends StatefulWidget {

  const MainScreen({super.key});

  @override
  State<StatefulWidget> createState() => _MainScreenState();

}

class _MainScreenState extends State<MainScreen> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((duration){
      GetIt.I.get<InfoUpdater>().startUpdater(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Where to?'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            UserLocation(),
            WhereToText(),
            SizedBox(height: 8),
            FindPlace(),
            PlacesList()
          ],
        ),
      ),
    );
  }

}