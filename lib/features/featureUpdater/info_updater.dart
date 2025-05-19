import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wdywtg/core/log/loger.dart';
import 'package:wdywtg/features/featureUpdater/model/weather_update_result.dart';
import 'package:wdywtg/features/featureUpdater/repository/update_data_repository_impl.dart';

class InfoUpdater {

  late final BuildContext context;
  late final _updateRepository = UpdateDataRepositoryImpl();

  static final String _logTag = 'InfoUpdater';
  Timer? updateTimer;

  Future<void> _update(Timer? timer) async {
    Log().i(_logTag, 'updater called');

    // Check if there are any places without weather


    // update weather
    final weatherUpdateResult = await _updateRepository.updateCachedWeather();
    Log().i(_logTag, 'weatherUpdateResult $weatherUpdateResult');
    switch(weatherUpdateResult){
      case Success(): break;
      case Error():
        if(context.mounted){
          final snackBar = SnackBar(content: Text('Can\'t update weather'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        break;
    }

    // update ai advices, if needed

    // update place photo, if old enough

    // update user place

  }

  void appResumed(BuildContext context){
    this.context = context;
    Log().i(_logTag, 'app resumed');
    if(updateTimer?.isActive != true){
      updateTimer?.cancel();
      updateTimer = null;
      startUpdater(context);
    }

  }

  void startUpdater(BuildContext context){
    Log().i(_logTag, 'updater started');
    this.context = context;
    if(updateTimer != null){ return; }
    updateTimer = Timer.periodic(Duration(hours: 1), _update);
    Future.delayed(Duration(seconds: 2), (){ _update(null); });
  }

  void cancelUpdater(){
    updateTimer?.cancel();
    updateTimer = null;
  }

}