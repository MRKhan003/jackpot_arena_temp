import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class Bankinfoprovider with ChangeNotifier {
  List<String> _bankLogo = [];
  List<String> _bankName = [];
  List<String> _filteredBankName = [];
  List<String> _filteredBankLogo = [];
  String _imageURL = '';
  int size = 100;
  int logoSize = 100;
  List<String> get bankLogo => _filteredBankLogo;
  List<String> get bankName => _filteredBankName;
  String get imageURL => _imageURL;
  Future<void> getBankData() async {
    try {
      CollectionReference reference =
          FirebaseFirestore.instance.collection('Banks');
      QuerySnapshot snapshot =
          await reference.orderBy('Bank_Name', descending: false).get();
      snapshot.docs.forEach((doc) {
        if (size != _bankName.length) {
          _bankName.add(doc['Bank_Name']);
        }
      });
      size = _bankName.length;
      print(_bankName);
      print(size);
      _filteredBankName = _bankName;
      notifyListeners();
    } on FirebaseException catch (e) {
      print(e.message);
    }
  }

  Future<void> loadImages() async {
    String downloadURL;
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      ListResult result = await storage.ref('BankIcons/').listAll();
      for (var ref in result.items) {
        if (logoSize != _bankLogo.length) {
          downloadURL = await ref.getDownloadURL();
          _bankLogo.add(downloadURL);
        }
      }
      logoSize = _bankLogo.length;
      print(logoSize);
      _filteredBankLogo = _bankLogo;
      notifyListeners();
    } catch (e) {
      print(e.toString);
    }
  }

  void searchBankAccounts(String query) {
    if (query.isEmpty) {
      _filteredBankName = _bankName;
      _filteredBankLogo = _bankLogo;
    } else {
      _filteredBankName = _bankName
          .where(
            (bankAccounts) => bankAccounts.toLowerCase().contains(
                  query.toLowerCase(),
                ),
          )
          .toList();
      _filteredBankLogo = _bankLogo
          .where(
            (bankAccount) => bankAccount.toLowerCase().contains(
                  query.toLowerCase(),
                ),
          )
          .toList();
    }
    notifyListeners();
  }
}
