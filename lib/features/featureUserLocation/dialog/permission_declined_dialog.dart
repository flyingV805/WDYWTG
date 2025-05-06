
import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:wdywtg/features/featureUserLocation/dialog/user_location_dialog.dart';

import '../bloc/ul_bloc.dart';
import '../bloc/ul_event.dart';

bool _isPresented = false;

class PermissionDeclinedDialog extends UserLocationDialog {

  final bool forever;

  PermissionDeclinedDialog({required this.forever});

  @override
  void show(BuildContext blocContext) {
    if(_isPresented) { return; }
    _isPresented = true;

    showDialog(
      context: blocContext,
      barrierDismissible: false,
      builder: (context){
        return AlertDialog(
          title: Text('You have denied a required permission for this feature'),
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
                if(forever){
                  // open apps permissions
                  AppSettings.openAppSettings(type: AppSettingsType.location);
                }else{
                  blocContext.read<UserLocationBloc>().add(RetryLocation());
                }
              },
              child: Text('Grant access')),
            TextButton(
              onPressed: (){
                _isPresented = false;
                Navigator.of(context).pop();
                blocContext.read<UserLocationBloc>().add(DisableFeature());
              },
              child: Text('Disable this feature')
            )
          ],
        );
      }
    );

  }

}