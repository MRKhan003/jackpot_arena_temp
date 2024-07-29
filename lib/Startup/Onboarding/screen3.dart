import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jackpot_arena/AccountAuth/accountCreation.dart';
import 'package:jackpot_arena/Startup/Onboarding/screen2.dart';

class Screen3 extends StatelessWidget {
  const Screen3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                      builder: (context) => const Screen2(),
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
          SizedBox(
            height: 25,
          ),
          SvgPicture.asset(
            "assets/Car.svg",
            height: 180,
          ),
          SizedBox(
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
          SizedBox(
            height: 20,
          ),
          Text(
            "Withdrawing your winnings is easy and\n secure. Simply play, win, and transfer\n your earnings directly to any bank\n account of your choice.",
            style: GoogleFonts.poppins(
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AccountCreation(),
                ),
              );
            },
            child: SvgPicture.asset(
              "assets/Button3.svg",
              height: 50,
            ),
          ),
        ],
      ),
    );
  }
}
