import 'package:cloud_firestore/cloud_firestore.dart';

class UserDetails {
  String? name, userName, email, password, cPassword, userID;
  int? gameCoins, realMoney;
  Timestamp? creationTime;
  bool? isLoadingStartupData;
  UserDetails({
    this.name,
    this.userName,
    this.email,
    this.password,
    this.cPassword,
    this.userID,
    this.isLoadingStartupData,
    this.gameCoins,
    this.realMoney,
  });
}
