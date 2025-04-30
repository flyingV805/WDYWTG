import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:wdywtg/features/featureUserLocation/bloc/ul_bloc.dart';
import 'package:wdywtg/features/featureUserLocation/bloc/ul_event.dart';
import 'package:wdywtg/features/featureUserLocation/dialog/user_location_dialog.dart';

bool _isPresented = false;

class AskForLocationDialog extends UserLocationDialog {

  @override
  void show(BuildContext blocContext) {
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
                  _isPresented = false;
                  Navigator.of(context).pop();
                  blocContext.read<UserLocationBloc>().add(UserApprovedLocation());
                },
                child: Text('Yes!')),
            TextButton(
                onPressed: (){
                  _isPresented = false;
                  Navigator.of(context).pop();
                  blocContext.read<UserLocationBloc>().add(UserDeclinedLocation());
                },
                child: Text('Not really')
            )
          ],
        );
      }
    ).then((_){});
  }

}
