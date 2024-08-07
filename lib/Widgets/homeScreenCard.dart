import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeCard extends StatelessWidget {
  String cardText, cardImage;
  HomeCard({
    required this.cardImage,
    required this.cardText,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      elevation: 0,
      clipBehavior: Clip.none,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(
            30,
          ),
        ),
      ),
      child: Column(
        children: [
          Image(
            image: AssetImage(
              cardImage,
            ),
            filterQuality: FilterQuality.high,
            height: 80,
            width: 100,
          ),
          // SizedBox(
          //   height: 10,
          // ),
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: Text(
              textAlign: TextAlign.center,
              cardText,
              style: GoogleFonts.poppins(
                fontSize: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
