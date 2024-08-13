import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jackpot_arena/Screens/homeScreen.dart';
import 'package:jackpot_arena/Startup/Onboarding/screen1.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  moveToIntro() {
    if (FirebaseAuth.instance.currentUser != null) {
      print(FirebaseAuth.instance.currentUser!.email);
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
            SizedBox(
              height: 100,
            ),
            CircularProgressIndicator(
              color: Color(0xffFF6007),
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
