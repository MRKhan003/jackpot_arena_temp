import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jackpot_arena/Firebase/userController.dart';
import 'package:jackpot_arena/Screens/homeScreen.dart';

class EditProfile extends StatefulWidget {
  String? currentUser;
  String? newUserName, newDisplayName, newEmail;
  String? currentUserName, currentDisplayName, currentEmail;
  List<String> firebaseLength = [];
  UserController controller = UserController();
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String profileImage;
  File? image;
  int running = 0;
  final ImagePicker _picker = ImagePicker();
  EditProfile({
    required this.profileImage,
  });

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  void initState() {
    getCurrentUser();
    getData();
    super.initState();
  }

  getProfileImage() async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('Users').get();
      snapshot.docs.forEach((doc) {
        if (doc['UserEmail'] == widget.currentUser) {
          setState(() {
            widget.profileImage = doc['ProfileImage'];
            widget.running = 0;
          });
        }
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

  getCurrentUser() async {
    try {
      widget.currentUser = await FirebaseAuth.instance.currentUser!.email;
      print(widget.currentUser);
      print(FirebaseAuth.instance.currentUser!.uid);
    } catch (e) {
      print(e);
    }
  }

  getData() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('Users').get();
      querySnapshot.docs.forEach((doc) {
        if (doc['UserEmail'] == FirebaseAuth.instance.currentUser!.email) {
          setState(() {
            widget.currentEmail = doc['UserEmail'];
            widget.currentUserName = doc['UserName'];
            widget.currentDisplayName = doc['Name'];
          });

          print(widget.currentUserName);
          print(widget.currentEmail);
          print(widget.currentDisplayName);
        }
      });
    } on FirebaseException catch (e) {
      print(e.message);
    }
  }

  Future<bool> isDisplayNameTaken(String? displayName) async {
    final result = await FirebaseFirestore.instance
        .collection('Users')
        .where('UserName', isEqualTo: displayName)
        .get();
    print('Name check');
    return result.docs.isNotEmpty;
  }

  Future<bool> isEmailTaken(String? email) async {
    final emailResult = await FirebaseFirestore.instance
        .collection('Users')
        .where('UserEmail', isEqualTo: email)
        .get();
    print('Email check');
    return emailResult.docs.isNotEmpty;
  }

  Future<bool> isUserTaken(String? userName) async {
    final nameResult = await FirebaseFirestore.instance
        .collection('Users')
        .where('Name', isEqualTo: userName)
        .get();
    print('Name');
    return nameResult.docs.isNotEmpty;
  }

  void _updateProfile(
    String? newDisplayName,
    String? newEmail,
    String? newUserName,
  ) async {
    // final newDisplayName = widget.controller.usernameController.text;
    // final newEmail = widget.controller.emailController.text;
    bool isTakenName;
    bool isTakenEmail;
    if (newDisplayName != null) {
      isTakenName = await isDisplayNameTaken(newDisplayName);
      if (isTakenName) {
        Fluttertoast.showToast(
          msg: 'User name already taken',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Color(0xffF8F8F8),
          textColor: Colors.red,
          fontSize: 16.0,
        );
      } else {
        // Proceed with updating the profile
        // Update the display name in Firestore
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(widget
                .currentUser) // Replace with the current user's document ID
            .update({'UserName': newDisplayName});

        // Clear the error message and provide user feedback
        Fluttertoast.showToast(
          msg: 'User name changed',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Color(0xffF8F8F8),
          textColor: Colors.green,
          fontSize: 16.0,
        );
      }
    }
    if (newEmail != null) {
      isTakenEmail = await isEmailTaken(newEmail);
      if (isTakenEmail) {
        Fluttertoast.showToast(
          msg: 'User email already taken',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Color(0xffF8F8F8),
          textColor: Colors.red,
          fontSize: 16.0,
        );
      } else {
        // Proceed with updating the profile
        // Update the display name in Firestore
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(widget
                .currentUser) // Replace with the current user's document ID
            .update({'UserEmail': newEmail});

        // Clear the error message and provide user feedback
        Fluttertoast.showToast(
          msg: 'User email changed',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Color(0xffF8F8F8),
          textColor: Colors.green,
          fontSize: 16.0,
        );
      }
    }
    if (newUserName != null) {
      isTakenName = await isEmailTaken(newUserName);
      if (isTakenName) {
        Fluttertoast.showToast(
          msg: 'User name already taken',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Color(0xffF8F8F8),
          textColor: Colors.red,
          fontSize: 16.0,
        );
      } else {
        // Proceed with updating the profile
        // Update the display name in Firestore
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(widget
                .currentUser) // Replace with the current user's document ID
            .update({'Name': newUserName});

        // Clear the error message and provide user feedback
        Fluttertoast.showToast(
          msg: 'User name changed',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Color(0xffF8F8F8),
          textColor: Colors.green,
          fontSize: 16.0,
        );
      }
    }
    if (newUserName == null && newEmail == null && newDisplayName == null) {
      Fluttertoast.showToast(
        msg: 'No changes made',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Color(0xffF8F8F8),
        textColor: Colors.green,
        fontSize: 16.0,
      );
    }
  }

  Future<void> _getImageFromGallery() async {
    //final picker = ImagePicker();
    final pickedFile =
        await widget._picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        widget.image = File(pickedFile.path);
      });
    }
    setState(() {
      widget.running = 1;
    });
    _updateProfileImage();
  }

  void deleteImage() async {
    try {
      final fileName = widget.profileImage;
      await widget._storage.ref().child(fileName).delete();
    } catch (e) {
      print(e);
    }
  }

  Future<String?> _uploadImage(File image) async {
    try {
      final fileName = 'ProfileImage/${FirebaseAuth.instance.currentUser!.uid}';

      final ref = widget._storage.ref().child(fileName);

      final uploadTask = await ref.putFile(image);

      final downloadUrl = await uploadTask.ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Failed to upload image",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: Color(0xffF8F8F8),
        textColor: Colors.red,
        fontSize: 16.0,
      );
      return null;
    }
  }

  Future<void> _updateProfileImage() async {
    if (widget.image != null) {
      final imageUrl = await _uploadImage(widget.image!);
      if (imageUrl != null) {
        // Update the user's Firestore document with the image URL
        //deleteImage();
        await widget._firestore
            .collection('Users')
            .doc(
              widget.currentUser,
            ) // Replace with the current user's document ID
            .update({'ProfileImage': imageUrl});
        getProfileImage();
        setState(() {
          widget.running = 0;
        });
      }
    } else {
      setState(() {
        widget.running = 0;
      });
      Fluttertoast.showToast(
        msg: "Please select an image",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: Color(0xffF8F8F8),
        textColor: Colors.black,
        fontSize: 16.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.running == 0 ? Colors.white : Colors.grey,
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: widget.running == 0 ? Colors.white : Colors.grey,
        surfaceTintColor: widget.running == 0 ? Colors.white : Colors.grey,
      ),
      body: DoubleBackToCloseApp(
        snackBar: SnackBar(
          content: Text('Back again to leave app.'),
        ),
        child: SingleChildScrollView(
          child: widget.currentDisplayName == null
              ? Center(
                  child: CircularProgressIndicator(
                    color: Color(
                      0xffEFCC4E,
                    ),
                  ),
                )
              : AbsorbPointer(
                  absorbing: widget.running == 1 ? true : false,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(
                              profileImage: widget.profileImage,
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 5,
                          ),
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: Icon(
                              Icons.arrow_back,
                              size: 28,
                              color: Color(0xffEFCC4E),
                            ),
                          ),
                        ),
                      ),
                      widget.running == 1
                          ? Center(
                              child: CircularProgressIndicator(
                                color: Color(0xffEFCC4E),
                              ),
                            )
                          : Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    _getImageFromGallery();
                                    //getProfileImage();
                                  },
                                  child: CircleAvatar(
                                    maxRadius: 72,
                                    minRadius: 52,
                                    backgroundColor: Colors.grey,
                                    child: CircleAvatar(
                                      maxRadius: 70,
                                      minRadius: 50,
                                      foregroundImage: widget.profileImage != ''
                                          ? NetworkImage(
                                              widget.profileImage,
                                            )
                                          : AssetImage(
                                              'assets/dp.jpg',
                                            ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _getImageFromGallery();
                                  },
                                  child: Container(
                                    //height: 100,
                                    constraints: BoxConstraints.tight(
                                      Size.fromRadius(70),
                                    ),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Colors.transparent,
                                          Color(0xffEFCC4E),
                                        ],
                                      ),
                                    ),
                                    child: Container(
                                      alignment: Alignment.bottomCenter,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 20),
                                        child: Icon(
                                          Icons.camera_alt,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 12,
                        ),
                        child: Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Username',
                            textAlign: TextAlign.left,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              color: Color(0xffEFCC4E),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          cursorColor: Colors.black26,
                          initialValue: widget.currentUserName!,
                          onChanged: (value) => setState(() {
                            widget.newUserName = value;
                          }),
                          decoration: InputDecoration(
                            fillColor: Colors.black,
                            focusColor: Color(0xffEFCC4E),
                            hoverColor: Color(0xffEFCC4E),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  10,
                                ),
                              ),
                              borderSide: BorderSide(
                                color: Color(0xffEFCC4E),
                              ),
                            ),
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  10,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 12,
                        ),
                        child: Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Email',
                            textAlign: TextAlign.left,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              color: Color(0xffEFCC4E),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          cursorColor: Colors.black26,
                          initialValue: widget.currentEmail!,
                          onChanged: (value) => setState(() {
                            widget.newEmail = value;
                          }),

                          //controller: widget.controller.emailController,
                          decoration: InputDecoration(
                            fillColor: Colors.black,
                            focusColor: Color(0xffEFCC4E),
                            hoverColor: Color(0xffEFCC4E),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  10,
                                ),
                              ),
                              borderSide: BorderSide(
                                color: Color(0xffEFCC4E),
                              ),
                            ),
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  10,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 12,
                        ),
                        child: Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Display Name',
                            textAlign: TextAlign.left,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              color: Color(0xffEFCC4E),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          cursorColor: Colors.black26,
                          initialValue: widget.currentDisplayName!,
                          onChanged: (value) => setState(() {
                            widget.newDisplayName = value;
                          }),
                          decoration: InputDecoration(
                            fillColor: Colors.black,
                            focusColor: Color(0xffEFCC4E),
                            hoverColor: Color(0xffEFCC4E),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  10,
                                ),
                              ),
                              borderSide: BorderSide(
                                color: Color(0xffEFCC4E),
                              ),
                            ),
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  10,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(
                              Color(0xffEFCC4E),
                            ),
                          ),
                          onPressed: () {
                            _updateProfile(
                              widget.newUserName,
                              widget.newEmail,
                              widget.newDisplayName,
                            );
                          },
                          child: Text(
                            'Save',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
