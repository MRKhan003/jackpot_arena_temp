import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jackpot_arena/AccountAuth/accountCreation.dart';
import 'package:jackpot_arena/ForgotPassword/emailScreen.dart';
import 'package:jackpot_arena/Startup/Onboarding/screen1.dart';
import 'package:jackpot_arena/Widgets/inputField.dart';
import 'package:jackpot_arena/Widgets/inputFieldController.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

class UserLogin extends StatelessWidget {
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
            "CREATE NEW ACCOUNT",
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
          Padding(
            padding: const EdgeInsets.only(
              left: 25,
              right: 25,
              bottom: 10,
            ),
            child: InputFields(
              fieldText: "Password",
              textController: controller.passwordController,
              keyboardType: TextInputType.visiblePassword,
              hideText: true,
              fieldIcon: Icons.visibility_off,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              right: 25,
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EmailScreen(),
                  ),
                );
              },
              child: Container(
                alignment: Alignment.centerRight,
                child: Text(
                  'Forgot Password?',
                  style: GoogleFonts.poppins(
                    color: Color.fromARGB(255, 206, 206, 46),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          RoundedLoadingButton(
            controller: buttonController,
            color: Color.fromARGB(255, 205, 187, 21),
            onPressed: () {},
            child: Text(
              'SIGN IN',
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Spacer(
            flex: 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Dont have an account?",
                style: GoogleFonts.poppins(
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                width: 10,
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
                child: Text(
                  "Sign up",
                  style: GoogleFonts.poppins(
                    color: Color.fromARGB(255, 210, 210, 26),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
