
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:wdywtg/features/featureUserLocation/dialog/user_location_dialog.dart';

import '../bloc/ul_bloc.dart';
import '../bloc/ul_event.dart';

bool _isPresented = false;

class GeocodeErrorDialog extends UserLocationDialog {

  @override
  void show(BuildContext blocContext) {

    if(_isPresented) { return; }
    _isPresented = true;

    showDialog(
      context: blocContext,
      barrierDismissible: false,
      builder: (context){
        return AlertDialog(
          title: Text('Unable to find the name of the place you are in'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset(
                'assets/lottie/location_request.json',
                width: 160
              ),
              SizedBox(height: 16),
              Text('There may be a problem with access to the network or geocoding provider.')
            ],
          ),
          actions: [
            TextButton(
              onPressed: (){
                _isPresented = false;
                Navigator.of(context).pop();
                blocContext.read<UserLocationBloc>().add(RetryGeocode());
              },
              child: Text('Retry')),
            TextButton(
              onPressed: (){
                _isPresented = false;
                Navigator.of(context).pop();
                blocContext.read<UserLocationBloc>().add(SkipGeocode());
              },
              child: Text('It\'s okay, it\'s not necessary.')
            )
          ],
        );
      }
    );

  }



}