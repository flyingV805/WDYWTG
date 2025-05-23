import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../bloc/find_bloc.dart';
import '../model/place_suggestion.dart';
import 'find_error_dialog.dart';

bool _isPresented = false;

class AdvicesErrorDialog extends FindErrorDialog {


  @override
  void show(
    BuildContext blocContext,
    PlaceSuggestion suggestion,
  ) {

    if(_isPresented) { return; }
    _isPresented = true;

    showDialog(
      context: blocContext,
      barrierDismissible: false,
      builder: (context){
        return AlertDialog(
          title: Text('Error searching for tips for ${suggestion.placeName}, ${suggestion.placeCountryCode}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset(
                'assets/lottie/location_request.json',
                width: 160
              ),
              SizedBox(height: 16),
              Text("It may be a problem with internet access or application problems.")
            ],
          ),
          actions: [
            TextButton(
              onPressed: (){
                _isPresented = false;
                Navigator.of(context).pop();
                blocContext.read<FindBloc>().add(RetryAdvices(placeToAdd: suggestion));
              },
              child: Text('Retry')
            ),
            TextButton(
              onPressed: (){
                _isPresented = false;
                Navigator.of(context).pop();
                blocContext.read<FindBloc>().add(SkipAdvices(placeToAdd: suggestion));
              },
              child: Text('I don\'t need advice')
            ),
          ],
        );
      }
    ).then((_){
      //_isPresented = false;
    });

  }

}