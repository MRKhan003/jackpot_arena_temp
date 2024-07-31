import 'package:cloud_firestore/cloud_firestore.dart';

class UserDetails {
  String? name, userName, email, password, cPassword, userID;
  Timestamp? creationTime;
  UserDetails({
    this.name,
    this.userName,
    this.email,
    this.password,
    this.cPassword,
    this.userID,
  });
}
