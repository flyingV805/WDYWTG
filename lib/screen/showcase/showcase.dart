import 'package:flutter/material.dart';
import 'package:wdywtg/screen/showcase/showcase_screen.dart';

class Showcase {

  static void start(BuildContext context){
    Navigator.push(context, ShowcaseRoute(builder: (context) => ShowcaseScreen()));
  }

}

class ShowcaseRoute<T> extends MaterialPageRoute<T> {

  ShowcaseRoute({required super.builder});
  //ShowcaseRoute({ required builder }) : super(builder: builder);

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child
  ) {
    return child;
  }
}