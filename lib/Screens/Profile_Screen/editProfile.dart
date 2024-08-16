import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jackpot_arena/Firebase/userController.dart';
import 'package:jackpot_arena/Screens/Profile_Screen/profileScreen.dart';

class EditProfile extends StatefulWidget {
  EditProfile({super.key});
  String? currentUser;
  String? newUserName, newDisplayName, newEmail;
  String? currentUserName, currentDisplayName, currentEmail;
  UserController controller = UserController();

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  void initState() {
    super.initState();
    getCurrentUser();
    getData();
  }

  getCurrentUser() async {
    try {
      widget.currentUser = await FirebaseAuth.instance.currentUser!.email;
      print(widget.currentUser);
    } catch (e) {
      print(e);
    }
  }

  Future<void> getData() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('Users').get();
      querySnapshot.docs.forEach((doc) {
        if (doc['UserEmail'] == widget.currentUser) {
          setState(() {
            widget.currentEmail = doc['UserEmail'];
            widget.currentUserName = doc['UserName'];
          });

          print(widget.currentUserName);
          print(widget.currentEmail);
        }
      });
    } on FirebaseException catch (e) {
      print(e.message);
    }
  }

  Future<void> setData(String? newEmail, String? newUserName) async {
    int temp = 0;
    int temp1 = 0;
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('Users').get();
      print('Loading...');
      snapshot.docs.forEach((doc) {
        if (doc['UserName'] != widget.newUserName ||
            doc['UserName'] != widget.newUserName!.toLowerCase()) {
          if (doc['UserEmail'] == widget.currentUser && temp > 0) {
            newEmail != null
                ? doc.reference.update({'UserEmail': newEmail})
                : doc.reference.update({'UserEmail': widget.currentEmail});
            newUserName != null
                ? doc.reference.update({'UserName': newUserName})
                : doc.reference.update({'UserName': widget.currentUserName});

            print(newEmail);
            print(newUserName);
          } else {
            temp1++;
            temp1 <= 1
                ? Fluttertoast.showToast(
                    msg: 'User name already taken',
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 3,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  )
                : null;
          }
        } else {
          setState(() {
            temp++;
          });
        }
      });
    } catch (e) {
      print(e);
    }
  }

  File? _image;

  Future<void> _getImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                maxRadius: 70,
                minRadius: 50,
                foregroundImage: _image != null
                    ? FileImage(_image!)
                    : AssetImage('assets/Logo2.png'),
              ),
              GestureDetector(
                onTap: () {
                  _getImageFromGallery();
                },
                child: Icon(
                  Icons.camera_alt,
                  size: 28,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextFormField(
              //initialValue: widget.currentUserName,
              controller: widget.controller.nameController,
              decoration: InputDecoration(
                //suffixText: widget.currentUserName,
                label: Text(
                  widget.currentUserName != null ? widget.currentUserName! : '',
                ),
                floatingLabelBehavior: FloatingLabelBehavior.never,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextFormField(
              //initialValue: widget.currentEmail,
              controller: widget.controller.emailController,
              decoration: InputDecoration(
                // suffixText: widget.currentEmail,
                // suffix: Text(widget.currentEmail!),
                label: Text(
                  widget.currentEmail != null ? widget.currentEmail! : '',
                ),
                floatingLabelBehavior: FloatingLabelBehavior.never,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextFormField(
                //initialValue: widget.currentEmail,
                //controller: widget.controller.emailController,
                ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton(
              onPressed: () {
                setData(
                  widget.controller.emailController.text,
                  widget.controller.nameController.text,
                );
              },
              child: Text(
                'Save',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
