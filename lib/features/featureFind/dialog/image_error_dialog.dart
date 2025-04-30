import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../bloc/find_bloc.dart';
import '../model/place_suggestion.dart';
import 'find_error_dialog.dart';

bool _isPresented = false;

class ImageErrorDialog extends FindErrorDialog {

  @override
  void show(BuildContext blocContext, PlaceSuggestion suggestion) {
    if (_isPresented) { return; }
    _isPresented = true;

    showDialog(
      context: blocContext,
      barrierDismissible: false,
      builder: (context){
        return AlertDialog(
          title: Text('Couldn\'t find a picture for ${suggestion.placeName}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset(
                'assets/lottie/location_request.json',
                width: 160
              ),
              SizedBox(height: 8),
              Text("There may be a problem with image provider or internet access.")
            ],
          ),
          actions: [
            TextButton(
              onPressed: (){
                _isPresented = false;
                Navigator.of(context).pop();
                blocContext.read<FindBloc>().add(RetryImage(placeToAdd: suggestion));
              },
              child: Text('Retry')
            ),
            TextButton(
              onPressed: (){
                _isPresented = false;
                Navigator.of(context).pop();
                blocContext.read<FindBloc>().add(SkipImage(placeToAdd: suggestion));
              },
              child: Text('Skip the picture')
            ),
          ],
        );
      }
    ).then((_){
      //_isPresented = false;
    });

  }

}