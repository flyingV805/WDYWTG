

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:wdywtg/features/featureFind/bloc/find_bloc.dart';
import 'package:wdywtg/features/featureFind/model/place_suggestion.dart';

import 'find_error_dialog.dart';

bool _isPresented = false;

class AlreadyAddedDialog extends FindErrorDialog {

  @override
  void show(
    BuildContext context,
    PlaceSuggestion suggestion,
  ) {

    if(_isPresented) { return; }
    _isPresented = true;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context){
        return AlertDialog(
          title: Text('${suggestion.placeName} has already been added to your list.'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset(
                'assets/lottie/location_request.json',
                width: 160
              ),
              SizedBox(height: 16),
              Text("${suggestion.placeName}, ${suggestion.placeCountryCode}"),
              SizedBox(height: 8),
              Text("I think you don't need two places in the same list, the application automatically updates the data")
            ],
          ),
          actions: [
            TextButton(
              onPressed: (){
                //context.read<FindBloc>().add(UserApprovedLocation());
                Navigator.of(context).pop();
              },
              child: Text('Ok, my bad')
            ),
          ],
        );
      }
    ).then((_){
      _isPresented = false;
    });

  }

}