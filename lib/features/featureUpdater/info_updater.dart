import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wdywtg/core/log/loger.dart';
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
    final weatherUpdateResult = _updateRepository.updateCachedWeather();

    // update ai advices, if needed

    // update place photo, if old enough

    // update user place

  }

  void appResumed(){

  }

  void startUpdater(BuildContext context){
    Log().i(_logTag, 'updater started');
    this.context = context;
    if(updateTimer != null){ return; }
    updateTimer = Timer.periodic(Duration(hours: 8), _update);
    Future.delayed(Duration(seconds: 2), (){ _update(null); });
  }

  void cancelUpdater(){
    updateTimer?.cancel();
    updateTimer = null;
  }

}