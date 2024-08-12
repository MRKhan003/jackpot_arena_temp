import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jackpot_arena/Screens/notificationScreen.dart';

class Counterprovider extends ChangeNotifier {
  int _notificationsCount = 0;
  int count = 0;
  int get notificationsCount => _notificationsCount;
  getNotificationCount() async {
    try {
      CollectionReference reference =
          FirebaseFirestore.instance.collection('Notifications');
      QuerySnapshot snapshot = await reference.get();
      print('calling');
      snapshot.docs.forEach((doc) {
        if (Notificationscreen().currentUser == doc['UserID'] &&
            doc['Status'] == 'unseen') {
          count++;
          print('getting...');
        }
      });
      _notificationsCount = count;
      notifyListeners();
    } catch (e) {
      print(e);
    }
    print(_notificationsCount);
    print(count);
  }
}
