import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jackpot_arena/AccountAuth/accountCreation.dart';
import 'package:jackpot_arena/Startup/Onboarding/screen2.dart';

class Screen1 extends StatelessWidget {
  const Screen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
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
                    color: Colors.white,
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
              const SizedBox(
                height: 20,
              ),
              Image.asset(
                "assets/Mining.png",
                height: 150,
                filterQuality: FilterQuality.high,
              ),
              const SizedBox(
                height: 40,
              ),
              Text(
                "Welcome to\nJackpotArena",
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
                  "Welcome to JackpotArena, the ultimate \n destination for thrilling games and real \n cash rewards. Get ready to play, win, \n and withdraw your earnings effortlessly.",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Screen2(),
                    ),
                  );
                },
                child: SvgPicture.asset(
                  "assets/Button1.svg",
                  height: 80,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
