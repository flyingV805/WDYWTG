
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:wdywtg/features/featureUserLocation/bloc/ul_event.dart';
import 'package:wdywtg/features/featureUserLocation/dialog/user_location_dialog.dart';

import '../bloc/ul_bloc.dart';

bool _isPresented = false;

class ImageErrorDialog extends UserLocationDialog {

  @override
  void show(BuildContext blocContext) {

    if(_isPresented) { return; }
    _isPresented = true;

    showDialog(
      context: blocContext,
      barrierDismissible: false,
      builder: (context){
        return AlertDialog(
          title: Text('Couldn\'t find a photo of the place where you are located'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset(
                'assets/lottie/location_request.json',
                width: 160
              ),
              SizedBox(height: 16),
              Text('There may be a problem with the internet or access to Unsplash')
            ],
          ),
          actions: [
            TextButton(
              onPressed: (){
                _isPresented = false;
                Navigator.of(context).pop();
                blocContext.read<UserLocationBloc>().add(RetryImage());
              },
              child: Text('Retry')
            ),
            TextButton(
              onPressed: (){
                _isPresented = false;
                Navigator.of(context).pop();
                blocContext.read<UserLocationBloc>().add(SkipImage());
              },
              child: Text('It\'s okay, it\'s not necessary.')
            )
          ],
        );
      }
    );

  }



}