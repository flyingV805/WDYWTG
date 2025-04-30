
import 'package:flutter/material.dart';
import 'package:wdywtg/features/featureUserLocation/dialog/user_location_dialog.dart';

bool _isPresented = false;

class ServiceDisabledDialog extends UserLocationDialog {

  @override
  void show(BuildContext blocContext) {
    if(_isPresented) { return; }
    _isPresented = true;

  }



}