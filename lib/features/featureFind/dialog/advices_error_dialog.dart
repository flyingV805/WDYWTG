import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../model/place_suggestion.dart';
import 'find_error_dialog.dart';

bool _isPresented = false;

class AdvicesErrorDialog extends FindErrorDialog {


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
                  //context.read<FindBloc>().add(UserApprovedLocation());
                Navigator.of(context).pop();
              },
              child: Text('Retry')
            ),
            TextButton(
              onPressed: (){
                //context.read<FindBloc>().add(UserApprovedLocation());
                Navigator.of(context).pop();
              },
              child: Text('I don\'t need advice')
            ),
          ],
        );
      }
    ).then((_){
      _isPresented = false;
    });

  }

}