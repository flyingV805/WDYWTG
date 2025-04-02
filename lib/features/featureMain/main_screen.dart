import 'package:flutter/material.dart';
import 'package:wdywtg/features/featureMain/widget/search_field.dart';

import 'widget/user_location.dart';


class MainScreen extends StatelessWidget {

  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Where to?'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            UserLocation(),
            SearchField()
          ],
        ),
      ),
    );
  }



}