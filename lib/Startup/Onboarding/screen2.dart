import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jackpot_arena/AccountAuth/accountCreation.dart';
import 'package:jackpot_arena/Startup/Onboarding/screen1.dart';
import 'package:jackpot_arena/Startup/Onboarding/screen3.dart';

class Screen2 extends StatelessWidget {
  const Screen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          builder: (context) => Screen1(),
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
                Padding(
                  padding: const EdgeInsets.only(
                    right: 20,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AccountCreation(),
                        ),
                      );
                    },
                    child: Container(
                      alignment: Alignment.topRight,
                      child: Text(
                        "Skip",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                        ),
                        //textAlign: TextAlign.right,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            SvgPicture.asset(
              "assets/Shiping.svg",
              height: 150,
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              "Earn Money with\n Plane Crash",
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
                "Discover the excitement of our Plane\n Crash game. Strategize your moves,\n play smart, and watch your winnings\n soar. It's your chance to earn real money\n while having fun!",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Screen3(),
                  ),
                );
              },
              child: SvgPicture.asset(
                "assets/Button2.svg",
                height: 80,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
