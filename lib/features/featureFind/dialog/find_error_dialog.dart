import 'package:flutter/cupertino.dart';

import '../model/place_suggestion.dart';

abstract class FindErrorDialog {

  void show(
    BuildContext context,
    PlaceSuggestion suggestion,
    Function() onRetry,
    Function() onCancel
  );

}