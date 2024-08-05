import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:jackpot_arena/AccountAuth/loginUser.dart';
import 'package:jackpot_arena/RootFunctionality/rootFunc.dart';
import 'package:jackpot_arena/Screens/homeScreen.dart';
import 'package:jackpot_arena/Startup/Onboarding/screen1.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final Connectivity _connectivity = Connectivity();
  moveToIntro() {
    if (FirebaseAuth.instance.currentUser != null) {
      Timer(Duration(seconds: 4), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
        );
      });
    } else {
      Timer(Duration(seconds: 4), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Screen1(),
          ),
        );
      });
    }
  }

  void initState() {
    super.initState();
    //getConnectivity();
    moveToIntro();
  }

  _navigateScreen() {
    // await Future.delayed(
    //   // const Duration(
    //   //   seconds: 5,
    //   // ),
    // );
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => moveToIntro(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(
              flex: 1,
            ),
            Image.asset(
              "assets/JACKPOTARENA.png",
              height: 35,
              width: 257,
              filterQuality: FilterQuality.high,
              alignment: Alignment.center,
            ),
            Image.asset(
              'assets/Airplane.png',
              height: 50,
              filterQuality: FilterQuality.high,
            ),
            const Spacer(
              flex: 1,
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 30,
              ),
              child: Text(
                "Powered by Corise",
                textAlign: TextAlign.end,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
