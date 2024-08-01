import 'package:flutter/material.dart';
import 'package:jackpot_arena/Firebase/firebaseFunctions.dart';
import 'package:jackpot_arena/RootFunctionality/rootFunc.dart';
import 'package:jackpot_arena/Startup/splashScreen.dart';
import 'package:provider/provider.dart';

class DetectRoot extends StatelessWidget {
  Firebasefunctions detector = Firebasefunctions();

  @override
  Widget build(BuildContext context) {
    detector = Provider.of<Firebasefunctions>(
      context,
      listen: false,
    );
    if (detector.currentUser.userID == null) {
      return FutureBuilder(
        future: detector.checkLoginInfo(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return RootFunc();
          } else {
            return SplashScreen();
          }
        },
      );
    } else {
      return RootFunc();
    }
  }
}
