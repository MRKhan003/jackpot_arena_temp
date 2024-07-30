import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jackpot_arena/Widgets/inputFieldController.dart';

class VerificationScreen extends StatelessWidget {
  FieldController controller = FieldController();
  TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 90,
          ),
          Center(
            child: SvgPicture.asset(
              "assets/JACKPOTARENA.svg",
              height: 20,
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Text(
            "VERIFY",
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              "Enter your 4 digit OTP code send\n by email address",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don’t receive a code ",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                "Send again",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: const Color.fromARGB(255, 204, 187, 31),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
