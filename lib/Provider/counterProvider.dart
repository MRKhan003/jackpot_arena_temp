import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jackpot_arena/Screens/notificationScreen.dart';

class Counterprovider extends ChangeNotifier {
  String? _currentEmail;
  String? get currentEmail => _currentEmail;
  getCurrentUser() async {
    try {
      _currentEmail = await FirebaseAuth.instance.currentUser!.email;
      notifyListeners();
      print(_currentEmail);
    } catch (e) {
      print(e);
    }
  }
}
