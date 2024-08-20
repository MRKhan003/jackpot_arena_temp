import 'package:circular_profile_avatar/circular_profile_avatar.dart';
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
  String? profileImage;
  Profilescreen({super.key});

  @override
  State<Profilescreen> createState() => _ProfilescreenState();
}

class _ProfilescreenState extends State<Profilescreen> {
  @override
  void initState() {
    super.initState();
    getCurrentUser();
    getProfileImage();
  }

  Future getProfileImage() async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('Users').get();
      snapshot.docs.forEach((doc) {
        if (doc['UserEmail'] == FirebaseAuth.instance.currentUser!.email) {
          widget.profileImage = doc['ProfileImage'];
        }
      });
    } on FirebaseException catch (e) {
      Fluttertoast.showToast(
        msg: e.message.toString(),
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
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
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  maxRadius: 70,
                  minRadius: 50,
                  foregroundImage: widget.profileImage != null
                      ? NetworkImage(
                          widget.profileImage!,
                        )
                      : AssetImage(
                          'assets/Logo2.png',
                        ),
                ),
                SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditProfile(),
                      ),
                    );
                  },
                  child: Text(
                    'Edit Profile',
                    style: GoogleFonts.poppins(
                      color: Color(0xffEFCC4E),
                    ),
                  ),
                ),
              ],
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
