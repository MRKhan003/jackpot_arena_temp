import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jackpot_arena/Controllers/transactionController.dart';
import 'package:jackpot_arena/Firebase/userDetails.dart';

class Transactiondetails extends StatefulWidget {
  String bankName;
  UserDetails userDetails = UserDetails();
  Transactioncontroller transactioncontroller = Transactioncontroller();
  double? userAmount;
  Transactiondetails({
    required this.bankName,
  });

  @override
  State<Transactiondetails> createState() => _TransactiondetailsState();
}

class _TransactiondetailsState extends State<Transactiondetails> {
  @override
  void initState() {
    super.initState();
    getCurrentUser();
    getData();
  }

  getData() async {
    //UserDetails setUser = UserDetails();
    try {
      CollectionReference getDataReference = FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .collection('Earning');
      QuerySnapshot snapshot = await getDataReference.get();
      snapshot.docs.forEach((doc) {
        setState(() {
          widget.userDetails.realMoney = doc['Real Money'];
        });
      });

      return true;
    } on FirebaseException catch (e) {
      print(e.message.toString());
      return false;
    }
  }

  getCurrentUser() async {
    try {
      widget.userDetails.email = await FirebaseAuth.instance.currentUser!.email;
      print(widget.userDetails.email);
    } catch (e) {
      print(e);
    }
  }

  setTransactionData(String bankName, String accountNumber, String amount,
      String displayName) async {
    try {
      await FirebaseFirestore.instance
          .collection('Transactions')
          .doc(
            Timestamp.now().toDate().toString(),
          )
          .set({
        'Bank': bankName,
        'Amount': amount,
        'Account Number': accountNumber,
        'Status': 'unseen',
        'TStatus': 'In-Progress',
        'Time': Timestamp.now(),
        'UserID': widget.userDetails.email,
        'Display Name': displayName,
      });
      Fluttertoast.showToast(
        msg: 'Request Sent',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } on FirebaseException catch (e) {
      print(e.message);
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
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                initialValue: widget.bankName,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Bank Name',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                controller:
                    widget.transactioncontroller.accountNumberController,
                keyboardType: TextInputType.name,
                readOnly: false,
                decoration: InputDecoration(
                  labelText: 'Account Number/Mobile Number',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
                maxLength: 14,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                controller: widget.transactioncontroller.nameController,
                keyboardType: TextInputType.name,
                readOnly: false,
                decoration: InputDecoration(
                  labelText: 'Display Name',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                controller: widget.transactioncontroller.amountController,
                keyboardType: TextInputType.number,
                readOnly: false,
                decoration: InputDecoration(
                  labelText: 'Amount',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                print(
                  int.parse(
                    widget.transactioncontroller.amountController.text,
                  ),
                );
                if (widget.transactioncontroller.accountNumberController.text
                        .isNotEmpty &&
                    widget.transactioncontroller.amountController.text
                        .isNotEmpty &&
                    widget
                        .transactioncontroller.nameController.text.isNotEmpty) {
                  if (widget.userDetails.realMoney! >=
                      int.parse(
                        widget.transactioncontroller.amountController.text,
                      )) {
                    setTransactionData(
                      widget.bankName,
                      widget.transactioncontroller.accountNumberController.text,
                      widget.transactioncontroller.amountController.text,
                      widget.transactioncontroller.nameController.text,
                    );
                  } else {
                    Fluttertoast.showToast(
                      msg:
                          'Amount entered should be less than or equal to earning.',
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 3,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  }
                } else {
                  Fluttertoast.showToast(
                    msg: 'Recheck your information and try again!',
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 3,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                }
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
