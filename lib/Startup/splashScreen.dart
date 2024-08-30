import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jackpot_arena/Providers/bankInfoProvider.dart';
import 'package:jackpot_arena/Screens/homeScreen.dart';
import 'package:jackpot_arena/Startup/Onboarding/screen1.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  String profileImage = '';
  bool loaded = false;
  SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    //getConnectivity();
    moveToIntro();

    super.initState();
  }

  moveToIntro() {
    if (FirebaseAuth.instance.currentUser != null) {
      print(FirebaseAuth.instance.currentUser!.email);
      FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .get()
          .then((DocumentSnapshot doc) {
        setState(() {
          widget.profileImage = doc['ProfileImage'];
        });
      });
      Timer(Duration(seconds: 3), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(
              profileImage: widget.profileImage,
            ),
          ),
        );
      });
    } else {
      Timer(Duration(seconds: 3), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Screen1(),
          ),
        );
      });
    }
  }

  // providerFunction() {
  //   if (widget.loaded == false) {
  //     var bankInfoProvider =
  //         Provider.of<Bankinfoprovider>(context, listen: false);
  //     WidgetsBinding.instance.addPostFrameCallback((_) {
  //       bankInfoProvider.getBankData();
  //       bankInfoProvider.loadImages();
  //     });
  //   }
  //   setState(() {
  //     widget.loaded = true;
  //   });
  // }

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
