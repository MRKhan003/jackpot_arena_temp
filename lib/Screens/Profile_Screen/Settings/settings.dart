import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jackpot_arena/Firebase/firebaseFunctions.dart';
import 'package:jackpot_arena/Firebase/userController.dart';
import 'package:jackpot_arena/Widgets/profileScreenWidget.dart';

class SettingsSection extends StatefulWidget {
  String? confirmEmail;
  UserController emailController = UserController();
  SettingsSection({super.key});

  @override
  State<SettingsSection> createState() => _SettingsSectionState();
}

class _SettingsSectionState extends State<SettingsSection> {
  void initState() {
    super.initState();
    getCurrentUser();
  }

  getCurrentUser() async {
    try {
      widget.confirmEmail = await FirebaseAuth.instance.currentUser!.email;
      print(widget.confirmEmail);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: GestureDetector(
                onTap: () => showDialogBoxforPassword(),
                child: Profilescreenwidget(
                  widgetContext: 'Change Password',
                  widgetIcon: Icons.password,
                  widgetColor: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: GestureDetector(
                onTap: () {
                  showDialogBox();
                },
                child: Profilescreenwidget(
                  widgetContext: 'Delete Account',
                  widgetIcon: Icons.remove,
                  widgetColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  showDialogBox() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Color(0xffEFCC4E),
        title: Text(
          'Confirm account delete!',
          style: GoogleFonts.poppins(
            color: Colors.white,
          ),
        ),
        content: Text(
          'Enter your email to delete account',
          style: GoogleFonts.poppins(
            color: Colors.white,
          ),
        ),
        contentPadding: EdgeInsets.fromLTRB(
          30,
          5,
          5,
          0,
        ),
        actions: [
          TextField(
            controller: widget.emailController.emailController,
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                print(widget.emailController.emailController.text);
                widget.emailController.emailController.text ==
                        widget.confirmEmail
                    ? Firebasefunctions().deleteUser(context)
                    : Fluttertoast.showToast(
                        msg: 'Invalid Email',
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 3,
                        backgroundColor: Color(0xffF8F8F8),
                        textColor: Colors.red,
                        fontSize: 16.0,
                      );
              },
              child: Text(
                'Confirm',
                style: GoogleFonts.poppins(
                  color: Color(0xffEFCC4E),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  showDialogBoxforPassword() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Color(0xffEFCC4E),
        title: Text(
          'Password Update',
          style: GoogleFonts.poppins(
            color: Colors.white,
          ),
        ),
        content: Text(
          'Fill the fields below',
          style: GoogleFonts.poppins(
            color: Colors.white,
          ),
        ),
        contentPadding: EdgeInsets.fromLTRB(
          30,
          5,
          5,
          0,
        ),
        actions: [
          TextField(
            controller: widget.emailController.emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              labelText: 'Email',
              labelStyle: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          TextField(
            controller: widget.emailController.passwordController,
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              labelText: 'Current Password',
              labelStyle: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          TextField(
            controller: widget.emailController.cPasswordController,
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              labelText: 'New Password',
              labelStyle: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                if (widget.emailController.emailController.text.isNotEmpty &&
                    widget.emailController.passwordController.text.isNotEmpty &&
                    widget
                        .emailController.cPasswordController.text.isNotEmpty) {
                  Firebasefunctions().reauthenticateUser(
                    widget.emailController.emailController.text,
                    widget.emailController.passwordController.text,
                    widget.emailController.cPasswordController.text,
                    context,
                  );
                } else {
                  Fluttertoast.showToast(
                    msg: 'Recheck your information and try again!',
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 3,
                    backgroundColor: Color(0xffF8F8F8),
                    textColor: Colors.red,
                    fontSize: 16.0,
                  );
                }
              },
              child: Text(
                'Confirm',
                style: GoogleFonts.poppins(
                  color: Color(0xffEFCC4E),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
