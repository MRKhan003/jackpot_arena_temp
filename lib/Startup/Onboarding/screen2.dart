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
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 30,
                ),
                child: Container(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Screen1(),
                        ),
                      );
                    },
                    child: SvgPicture.asset(
                      "assets/BackButton.svg",
                      height: 35,
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
                    Navigator.push(
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
                      style: GoogleFonts.notoNastaliqUrdu(
                        fontSize: 18,
                      ),
                      //textAlign: TextAlign.right,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          SvgPicture.asset(
            "assets/Shiping.svg",
            height: 180,
          ),
          SizedBox(
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
          SizedBox(
            height: 20,
          ),
          Text(
            "Discover the excitement of our Plane\n Crash game. Strategize your moves,\n play smart, and watch your winnings\n soar. It's your chance to earn real money\n while having fun!",
            style: GoogleFonts.poppins(
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Screen3(),
                ),
              );
            },
            child: SvgPicture.asset(
              "assets/Button2.svg",
              height: 50,
            ),
          ),
        ],
      ),
    );
  }
}
