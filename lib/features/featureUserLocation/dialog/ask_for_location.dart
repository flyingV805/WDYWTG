import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:wdywtg/features/featureUserLocation/bloc/ul_bloc.dart';
import 'package:wdywtg/features/featureUserLocation/bloc/ul_event.dart';

bool _isPresented = false;

void askForLocationDialog(
  BuildContext blocContext,
){
  if(_isPresented) { return; }
  _isPresented = true;
  showDialog(
    context: blocContext,
    barrierDismissible: false,
    builder: (context){
      return AlertDialog(
        title: Text('Would you like to share your location?'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(
              'assets/lottie/location_request.json',
              width: 160
            ),
            SizedBox(height: 16),
            Text('This will improve recommendations for clothing and footwear, and show the weather in your location.')
          ],
        ),
        actions: [
          TextButton(
            onPressed: (){
              blocContext.read<UserLocationBloc>().add(UserApprovedLocation());
              Navigator.of(context).pop();
            },
            child: Text('Yes!')),
          TextButton(
            onPressed: (){
              blocContext.read<UserLocationBloc>().add(UserDeclinedLocation());
              Navigator.of(context).pop();
            },
            child: Text('Not really')
          )
        ],
      );
    }
  ).then((_){
    _isPresented = false;
  });

}