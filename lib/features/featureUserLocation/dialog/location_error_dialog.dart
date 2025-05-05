
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:wdywtg/features/featureUserLocation/dialog/user_location_dialog.dart';

bool _isPresented = false;

class LocationErrorDialog extends UserLocationDialog {

  @override
  void show(BuildContext blocContext) {
    if(_isPresented) { return; }
    _isPresented = true;

    showDialog(
      context: blocContext,
      barrierDismissible: false,
      builder: (context){
        return AlertDialog(
          title: Text('Unable to access location'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset(
                'assets/lottie/location_request.json',
                width: 160
              ),
              SizedBox(height: 16),
              Text('If you want to use this feature, you need to grant location access..')
            ],
          ),
          actions: [
            TextButton(
              onPressed: (){
                _isPresented = false;
                Navigator.of(context).pop();
                //blocContext.read<UserLocationBloc>().add(UserApprovedLocation());
              },
              child: Text('Retry')
            ),
            TextButton(
              onPressed: (){
                _isPresented = false;
                Navigator.of(context).pop();
                //blocContext.read<UserLocationBloc>().add(UserDeclinedLocation());
              },
              child: Text('Disable this feature')
            )
          ],
        );
      }
    );

  }


}