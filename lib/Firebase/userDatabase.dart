import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jackpot_arena/Firebase/userDetails.dart';

class UserDatabase {
  UserDetails currentUser = UserDetails();
  final FirebaseFirestore ffObject = FirebaseFirestore.instance;
  Future<bool> sendUserData(UserDetails details) async {
    try {
      await ffObject.collection('Users').doc(details.userID).set({
        'UserID': details.userID,
        'UserName': details.userName,
        'UserEmail': details.email,
      });
      return true;
    } catch (e) {
      Fluttertoast.showToast(
          msg: "$e",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      return false;
    }
  }

  Future<UserDetails> getUserbyID(String uid) async {
    UserDetails setUser = UserDetails();
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await ffObject.collection("Users").doc(currentUser.userID).get();
    setUser.userID = documentSnapshot.data()!["UserID"];
    setUser.userName = documentSnapshot.data()!["UserName"];
    setUser.email = documentSnapshot.data()!["UserEmail"];
    return setUser;
  }
}
