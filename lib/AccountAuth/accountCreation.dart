import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jackpot_arena/AccountAuth/loginUser.dart';
import 'package:jackpot_arena/Widgets/inputField.dart';
import 'package:jackpot_arena/Widgets/inputFieldController.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

class AccountCreation extends StatelessWidget {
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
              fieldText: "Name",
              textController: controller.nameController,
              keyboardType: TextInputType.name,
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
              fieldText: "User Name",
              textController: controller.userNameController,
              keyboardType: TextInputType.name,
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
              fieldText: "Email",
              textController: controller.emailController,
              keyboardType: TextInputType.emailAddress,
              hideText: false,
              fieldIcon: Icons.email,
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
              left: 25,
              right: 25,
              bottom: 10,
            ),
            child: InputFields(
              fieldText: "Confirm Password",
              textController: controller.passwordConfirmController,
              keyboardType: TextInputType.visiblePassword,
              hideText: true,
              fieldIcon: Icons.visibility_off,
            ),
          ),
          RoundedLoadingButton(
            controller: buttonController,
            color: Color.fromARGB(255, 205, 187, 21),
            onPressed: () {},
            child: Text(
              'SIGN UP',
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
                "Already have an account?",
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
                      builder: (context) => UserLogin(),
                    ),
                  );
                },
                child: Text(
                  "Sign in",
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
