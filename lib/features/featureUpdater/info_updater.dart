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
    final weatherUpdateResult = _updateRepository.updateCachedWeather();

  }

  void startUpdater(BuildContext context){
    Log().i(_logTag, 'updater started');
    this.context = context;
    updateTimer = Timer.periodic(Duration(hours: 8), _update);
    Future.delayed(Duration(seconds: 2), (){ _update(null); });
  }

  void cancelUpdater(){
    updateTimer?.cancel();
    updateTimer = null;
  }

}