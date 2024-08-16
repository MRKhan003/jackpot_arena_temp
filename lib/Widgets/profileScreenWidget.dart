import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Profilescreenwidget extends StatelessWidget {
  String widgetContext;
  IconData widgetIcon;
  Color? widgetColor;
  Profilescreenwidget({
    required this.widgetContext,
    required this.widgetIcon,
    this.widgetColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widgetColor == null ? Color(0xffEFCC4E) : widgetColor,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Text(widgetContext),
            Spacer(),
            Icon(widgetIcon),
          ],
        ),
      ),
    );
  }
}
