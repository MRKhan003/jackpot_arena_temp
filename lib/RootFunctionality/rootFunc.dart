import 'package:flutter/material.dart';
import 'package:jackpot_arena/AccountAuth/accountCreation.dart';
import 'package:jackpot_arena/AccountAuth/loginUser.dart';
import 'package:jackpot_arena/Firebase/firebaseFunctions.dart';
import 'package:jackpot_arena/Firebase/userController.dart';
import 'package:jackpot_arena/Screens/homeScreen.dart';
import 'package:jackpot_arena/Startup/Onboarding/screen1.dart';
import 'package:jackpot_arena/Startup/splashScreen.dart';
import 'package:provider/provider.dart';

enum authentication {
  firstTime,
  authenticating,
  notLogedin,
  logedIn,
}

class RootFunc extends StatelessWidget {
  authentication authStatus = authentication.authenticating;
  @override
  Widget build(BuildContext context) {
    Firebasefunctions controller = Firebasefunctions();
    controller = Provider.of<Firebasefunctions>(
      context,
      listen: false,
    );
    return FutureBuilder(
      future: null,
      builder: (context, snapshot) {
        if (controller.currentUser.userID == null) {
          authStatus = authentication.firstTime;
        }
        if (controller.currentUser.userID != null) {
          authStatus = authentication.logedIn;
        }
        switch (authStatus) {
          case authentication.authenticating:
            return const SplashScreen();
          case authentication.firstTime:
            return Screen1();
          case authentication.logedIn:
            return HomeScreen();
          default:
            return SplashScreen();
        }
      },
    );
  }
}
