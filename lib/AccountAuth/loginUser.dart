import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jackpot_arena/AccountAuth/accountCreation.dart';
import 'package:jackpot_arena/ForgotPassword/emailScreen.dart';
import 'package:jackpot_arena/Widgets/inputField.dart';
import 'package:jackpot_arena/Widgets/inputFieldController.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

class UserLogin extends StatefulWidget {
  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  FieldController controller = FieldController();
  RoundedLoadingButtonController buttonController =
      RoundedLoadingButtonController();
  bool validate = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
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
              "CREATE NEW ACCOUNT",
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
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
                fieldIcon: Icons.email_outlined,
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
                  Navigator.push(
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
                      color: const Color.fromARGB(255, 206, 206, 46),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            RoundedLoadingButton(
              controller: buttonController,
              resetAfterDuration: true,
              resetDuration: Duration(seconds: 5),
              completionDuration: const Duration(seconds: 3),
              color: const Color.fromARGB(255, 205, 187, 21),
              onPressed: () {
                if (controller.emailController.text.isEmpty &&
                    controller.passwordController.text.isEmpty) {
                  Fluttertoast.showToast(
                      msg: "Fill all fields",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 5,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                } else {}
              },
              child: Text(
                'SIGN IN',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 30,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Dont have an account?",
                    style: GoogleFonts.poppins(
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
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
                    child: Text(
                      "Sign up",
                      style: GoogleFonts.poppins(
                        color: const Color.fromARGB(255, 210, 210, 26),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
