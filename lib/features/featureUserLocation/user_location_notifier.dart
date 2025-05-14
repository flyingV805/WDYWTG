import 'package:flutter/material.dart';
import 'package:wdywtg/core/log/loger.dart';

class UserLocationFeatureState extends ChangeNotifier {

  static final String _logTag = 'UserLocationFeatureState';

  bool featureEnabled = false;

  Function(bool)? _stateListener;

  void setListener(Function(bool)? stateListener){
    _stateListener = stateListener;
    Log().w(_logTag, 'setListener');
  }

  void setInitialState(bool enabled){
    featureEnabled = enabled;
  }

  void flipState(){
    featureEnabled = !featureEnabled;
    Log().w(_logTag, 'flipState called');
    if(_stateListener != null) {
      _stateListener!(featureEnabled);
      Log().w(_logTag, 'flipState called function');
    }
    notifyListeners();
  }

  void updateState(bool state){
    featureEnabled = state;
    if(_stateListener != null) { _stateListener!(featureEnabled); }
    notifyListeners();
  }

}