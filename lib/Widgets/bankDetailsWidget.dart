import 'package:flutter/material.dart';

class Bankdetailswidget extends StatelessWidget {
  String widgetImage, widgetContext;
  Bankdetailswidget({
    required this.widgetContext,
    required this.widgetImage,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 8,
          left: 8,
          right: 8,
        ),
        child: Row(
          children: [
            CircleAvatar(
              foregroundColor: Colors.white,
              backgroundColor: Colors.white,
              foregroundImage: NetworkImage(
                widgetImage,
              ),
              maxRadius: 30,
              minRadius: 20,
            ),
            SizedBox(
              width: 10,
            ),
            Text(widgetContext),
            Spacer(),
            Icon(Icons.arrow_right)
          ],
        ),
      ),
    );
  }
}
