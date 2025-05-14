import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';
import '../../uiKit/whereToText/where_to_text.dart';

class ShowcaseScreen extends StatefulWidget {

  final bool ulEnabled;
  final Function() onFinished;

  const ShowcaseScreen({
    super.key,
    required this.ulEnabled,
    required this.onFinished,
  });

  @override
  State<StatefulWidget> createState() => _ShowcaseScreenState();

}

final class _ShowcaseScreenState extends State<ShowcaseScreen> {

  BuildContext? _showcaseContext;
  final GlobalKey _userLocation = GlobalKey();
  final GlobalKey _settings = GlobalKey();

  @override
  void initState() {

    WidgetsBinding.instance.addPostFrameCallback((duration){
      Future.delayed(
        Duration(milliseconds: 350),
        (){
          if(_showcaseContext != null){
            ShowCaseWidget.of(_showcaseContext!).startShowCase([_userLocation]);
          }
        }
      );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ShowCaseWidget(
      builder: (context) {
        _showcaseContext = context;
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Showcase(
                key: _userLocation,
                description: 'dfsdfsdfsdfsdfsdf',
                child: SizedBox(width: double.infinity, height: 186)
              )
            ),
            Text('sdfsdfsdfsdfsdf')
        ],
        );
      },
      onFinish: (){ widget.onFinished(); },
    );
  }

}