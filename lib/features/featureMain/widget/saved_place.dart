import 'package:flutter/material.dart';

class SavedPlace extends StatefulWidget {

  const SavedPlace({super.key});

  @override
  State<StatefulWidget> createState() => _SavedPlaceState();

}

class _SavedPlaceState extends State<SavedPlace>{

  late AnimationController _animationController;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
/*
  Widget _buildChildren(BuildContext context, Widget? child) {

  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController.view,
      builder: _buildChildren,
      child: shouldRemoveChildren ? null : result,
    );
  }
*/
}