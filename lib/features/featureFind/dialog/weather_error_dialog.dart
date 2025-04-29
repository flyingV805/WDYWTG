import 'package:flutter/material.dart';
import '../model/place_suggestion.dart';
import 'find_error_dialog.dart';

bool _isPresented = false;

class WeatherErrorDialog extends FindErrorDialog {

  @override
  void show(BuildContext context, PlaceSuggestion suggestion) {
    if (_isPresented) { return; }
    _isPresented = true;



  }

}