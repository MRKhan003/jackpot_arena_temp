import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jackpot_arena/Firebase/firebaseFunctions.dart';
import 'package:jackpot_arena/Screens/Profile_Screen/Settings/settings.dart';
import 'package:jackpot_arena/Screens/Profile_Screen/Transaction/banksDetails.dart';
import 'package:jackpot_arena/Screens/Profile_Screen/editProfile.dart';
import 'package:jackpot_arena/Widgets/profileScreenWidget.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

class Profilescreen extends StatefulWidget {
  RoundedLoadingButtonController buttonController =
      RoundedLoadingButtonController();
  String? confirmEmail;
  String profileImage = '';
  bool ref = true;
  Profilescreen({super.key});

  @override
  State<Profilescreen> createState() => _ProfilescreenState();
}

class _ProfilescreenState extends State<Profilescreen> {
  @override
  void initState() {
    getProfileImage();
    super.initState();
  }

  getProfileImage() async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('Users').get();
      snapshot.docs.forEach((doc) {
        if (doc['UserEmail'] == FirebaseAuth.instance.currentUser!.email) {
          setState(() {
            widget.profileImage = doc['ProfileImage'];
          });
        }
        setState(() {
          widget.profileImage != '' ? widget.ref = true : widget.ref = false;
        });
      });
    } on FirebaseException catch (e) {
      Fluttertoast.showToast(
        msg: e.message.toString(),
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Color(0xffF8F8F8),
        textColor: Colors.red,
        fontSize: 16.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  maxRadius: 72,
                  minRadius: 52,
                  backgroundColor: Colors.grey,
                  child: CircleAvatar(
                    maxRadius: 70,
                    minRadius: 50,
                    backgroundColor: Colors.white,
                    foregroundImage: widget.ref == true
                        ? NetworkImage(
                            widget.profileImage,
                          )
                        : AssetImage(
                            'assets/dp.jpg',
                          ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      Color(0xffEFCC4E),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditProfile(
                          profileImage: widget.profileImage == ''
                              ? ''
                              : widget.profileImage,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    'Edit Profile',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 18,
              ),
              child: Container(
                alignment: Alignment.topLeft,
                child: Text(
                  'Account',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    color: Color(0xffEFCC4E),
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SettingsSection(),
                  ),
                ),
                child: Profilescreenwidget(
                  widgetContext: 'Settings',
                  widgetIcon: Icons.settings,
                  widgetColor: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 18,
              ),
              child: Container(
                alignment: Alignment.topLeft,
                child: Text(
                  'Actions',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    color: Color(0xffEFCC4E),
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Banksdetails(),
                  ),
                ),
                child: Profilescreenwidget(
                  widgetContext: 'Withdraw Amount',
                  widgetIcon: Icons.money,
                  widgetColor: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 18,
              ),
              child: Container(
                alignment: Alignment.topLeft,
                child: Text(
                  'Support and About',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    color: Color(0xffEFCC4E),
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: GestureDetector(
                // onTap: () => Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => SettingsSection(),
                //   ),
                // ),
                child: Profilescreenwidget(
                  widgetContext: 'Terms and Conditions',
                  widgetIcon: Icons.file_open,
                  widgetColor: Colors.white,
                ),
              ),
            ),
            //Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: RoundedLoadingButton(
                color: Colors.red,
                controller: widget.buttonController,
                onPressed: () {
                  Firebasefunctions().logout(context);
                },
                child: Text(
                  'Logout',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
