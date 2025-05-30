import 'package:flutter/material.dart';

class PlacesListFeatureState extends ChangeNotifier {

  bool expandLast = false;

  void setInitial(bool expandLast){
    this.expandLast = expandLast;
  }



}