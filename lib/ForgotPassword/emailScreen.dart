import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jackpot_arena/ForgotPassword/verificationScreen.dart';
import 'package:jackpot_arena/Widgets/inputField.dart';
import 'package:jackpot_arena/Widgets/inputFieldController.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

class EmailScreen extends StatelessWidget {
  FieldController controller = FieldController();
  RoundedLoadingButtonController buttonController =
      RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 90,
          ),
          Center(
            child: SvgPicture.asset(
              "assets/JACKPOTARENA.svg",
              height: 20,
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Text(
            "FORGOT PASSWORD",
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 25,
              right: 25,
              bottom: 10,
            ),
            child: InputFields(
              fieldText: "Email",
              textController: controller.emailController,
              keyboardType: TextInputType.emailAddress,
              hideText: false,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          RoundedLoadingButton(
            controller: buttonController,
            color: Color.fromARGB(255, 205, 187, 21),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => VerificationScreen(),
                ),
              );
            },
            child: Text(
              'CONTINUE',
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
