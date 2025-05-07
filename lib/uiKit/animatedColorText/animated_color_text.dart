import 'package:flutter/material.dart';
import 'package:wdywtg/commonModel/place_picture_palette.dart';

class AnimatedColorText extends StatefulWidget {

  final String text;
  final TextStyle? style;
  final PlacePicturePalette? palette;

  const AnimatedColorText({
    super.key,
    required this.text,
    required this.style,
    required this.palette
  });

  @override
  State<StatefulWidget> createState() => _AnimatedColorTextState();

}

class _AnimatedColorTextState extends State<AnimatedColorText> {

  @override
  void didChangeDependencies() {
    setState(() {});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final decorationColor = switch(widget.palette){
      null => null,
      PlacePicturePalette.light => Colors.white,
      PlacePicturePalette.dark => Colors.black,
    };
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(opacity: animation, child: child);
      },
      child: Text(
        widget.text,
        style: widget.style?.copyWith(
          color: decorationColor,
          decorationColor: decorationColor
        ),
      ),
    );
  }

}