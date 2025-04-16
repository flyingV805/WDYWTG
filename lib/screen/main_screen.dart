import 'package:flutter/material.dart';

import '../features/featureFind/find_place.dart';
import '../features/featureList/places_list.dart';
import '../features/featureUserLocation/user_location.dart';
import '../uiKit/whereToText/where_to_text.dart';

class MainScreen extends StatelessWidget {

  const MainScreen({super.key});

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