
import 'package:flutter/material.dart';

void askForLocationDialog(
  BuildContext context
){

  showDialog(
    context: context,
    builder: (context){
      return AlertDialog(
        title: Text('123'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [],
        ),
        actions: [
          TextButton(onPressed: (){}, child: Text('123')),
          TextButton(onPressed: (){}, child: Text('321'))
        ],
      );
    }
  );

}