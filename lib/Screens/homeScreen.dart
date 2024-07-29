import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/me 2.svg',
                  height: 20,
                ),
                Icon(
                  Icons.notifications,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
