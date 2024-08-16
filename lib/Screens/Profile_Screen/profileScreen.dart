import 'dart:io';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jackpot_arena/Firebase/firebaseFunctions.dart';
import 'package:jackpot_arena/Screens/Profile_Screen/Settings/settings.dart';
import 'package:jackpot_arena/Screens/Profile_Screen/Transaction/banksDetails.dart';
import 'package:jackpot_arena/Screens/Profile_Screen/editProfile.dart';
import 'package:jackpot_arena/Widgets/profileScreenWidget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';
import 'package:image/image.dart' as im;
import 'package:uuid/uuid.dart';

class Profilescreen extends StatefulWidget {
  RoundedLoadingButtonController buttonController =
      RoundedLoadingButtonController();
  String? confirmEmail;
  Profilescreen({super.key});

  @override
  State<Profilescreen> createState() => _ProfilescreenState();
}

class _ProfilescreenState extends State<Profilescreen> {
  // ImagePicker img = ImagePicker();
  // File? file;
  // bool isUploading = false;
  // String postId = Uuid().v4();
  // handleChooseFromGallery() async {
  //   var pickImage = await img.pickImage(
  //     source: ImageSource.gallery,
  //     maxWidth: 1080,
  //     maxHeight: 960,
  //   );
  //   File imgFile = File(pickImage!.path);

  //   setState(() {
  //     file = imgFile;
  //   });

  //   uploadinFromStorage() async {
  //     isUploading = true;
  //   }

  //   if (file != null) {}
  //   await compressImage();
  //   String? storage = await uploadImage();

  //   // if (storage != null) {
  //   //   await uploadAvatartoFirestore();
  //   // }
  //   // uploadAvatartoFirestore({String mediaUrl,String uid})async{

  //   //   await FirebaseFirestore.instance.collection("Users").doc().update({"avatarURl":mediaUrl})

  //   // }
  // }

  // Future<String?> uploadImage() async {
  //   UploadTask uploadTask = FirebaseStorage.instance
  //       .ref()
  //       .child("profilepicture/$postId.jpg")
  //       .putFile(file!);
  //   String? downloadURL;
  //   uploadTask.then((p0) async {
  //     downloadURL = await p0.ref.getDownloadURL();
  //   });
  //   return downloadURL;
  // }

  // compressImage() async {
  //   final tempFile = await getTemporaryDirectory();
  //   final path = tempFile.path;
  //   im.Image? imageFile = im.decodeImage(file!.readAsBytesSync());
  //   final compressedFile = File("$path/image_$postId.jpg")
  //     ..writeAsBytesSync(
  //       im.encodeJpg(imageFile!),
  //     );
  //   setState(() {
  //     file = compressedFile;
  //   });
  // }
  @override
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
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Center(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircularProfileAvatar(
                  '',
                  onTap: () {
                    print("Tapped");
                  },
                  imageFit: BoxFit.fill,
                  backgroundColor: Colors.cyan,
                  radius: 55,
                  initialsText: Text(
                    "+",
                    style: GoogleFonts.poppins(
                      fontSize: 30,
                      color: Colors.white,
                    ),
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
              ),
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SettingsSection(),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Profilescreenwidget(
                widgetContext: 'Settings',
                widgetIcon: Icons.settings,
              ),
            ),
          ),
          Spacer(),
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
    );
  }
}
