import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:jackpot_arena/AccountAuth/accountCreation.dart';
import 'package:jackpot_arena/Startup/Onboarding/screen2.dart';

class Screen3 extends StatefulWidget {
  const Screen3({super.key});

  @override
  State<Screen3> createState() => _Screen3State();
}

class _Screen3State extends State<Screen3> {
  late StreamSubscription subscription;
  var isDeviceConnected = false;
  bool isAlertSet = false;

  @override
  void initState() {
    super.initState();
    getConnectivity();
  }

  getConnectivity() {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) async {
      isDeviceConnected = await InternetConnectionChecker().hasConnection;
      if (!isDeviceConnected && isAlertSet == false) {
        showDialogBox();
        setState(() {
          isAlertSet = true;
        });
      }
    });
  }

  showDialogBox() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          insetPadding: EdgeInsets.all(0),
          alignment: Alignment.bottomCenter,
          backgroundColor: Colors.red,
          shape: BeveledRectangleBorder(),
          iconPadding: EdgeInsets.all(0),
          icon: Icon(
            Icons.wifi_off,
            color: Colors.white,
          ),
          contentPadding: EdgeInsets.only(left: 5),
          content: Text(
            'Internet Connection Lost',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              color: Colors.white,
            ),
          ),
          buttonPadding: EdgeInsets.all(0),
          actionsPadding: EdgeInsets.all(0),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.pop(context, 'Cancel');
                setState(() {
                  isAlertSet = false;
                });
                isDeviceConnected =
                    await InternetConnectionChecker().hasConnection;
                if (!isDeviceConnected) {
                  showDialogBox();
                  setState(() {
                    isAlertSet = true;
                  });
                }
              },
              child: Text(
                'Continue',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Screen2(),
                    ),
                  );
                },
                child: Container(
                  alignment: Alignment.topLeft,
                  child: SvgPicture.asset(
                    'assets/BackButton.svg',
                    height: 30,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Image.asset(
              'assets/AirplaneMoney.png',
              height: 150,
              filterQuality: FilterQuality.high,
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              "Easy Withdrawals \n to Your Bank ",
              style: GoogleFonts.poppins(
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 15,
                right: 15,
              ),
              child: Text(
                "Withdrawing your winnings is easy and\n secure. Simply play, win, and transfer\n your earnings directly to any bank\n account of your choice.",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AccountCreation(),
                  ),
                );
              },
              child: SvgPicture.asset(
                "assets/Button3.svg",
                height: 80,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
