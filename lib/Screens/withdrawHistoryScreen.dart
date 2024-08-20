import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jackpot_arena/Firebase/userDetails.dart';
import 'package:jackpot_arena/Widgets/transactionWidget.dart';

class Withdrawhistoryscreen extends StatefulWidget {
  UserDetails user = UserDetails();
  bool isTapped = false;
  List<String> withdrawMessage = [];
  List<String> tStatus = [];
  List<Timestamp> withdrawTimeStamps = [];
  List<String> withdrawStatus = [];
  List<String> amount = [];
  List<String> bankIcon = [];
  bool ref = true;
  int size = 100;
  String? currentUser;
  Withdrawhistoryscreen({super.key});
  @override
  State<Withdrawhistoryscreen> createState() => _WithdrawhistoryscreenState();
}

class _WithdrawhistoryscreenState extends State<Withdrawhistoryscreen> {
  @override
  void initState() {
    getData();
    _getTransactionData();
    setData();
    super.initState();
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
          widget.user.gameCoins = doc['Game Coins'];
          widget.user.realMoney = doc['Real Money'];
        });
      });

      print(widget.user.gameCoins);
      return true;
    } on FirebaseException catch (e) {
      print(e.message.toString());
      return false;
    }
  }

  Future<void> setData() async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('Transactions').get();
      print('Loading...');
      snapshot.docs.forEach((doc) {
        if (doc['UserID'] == widget.currentUser) {
          doc.reference.update({'Status': 'Seen'});
        }
      });
    } catch (e) {}
  }

  _getTransactionData() async {
    try {
      CollectionReference reference =
          FirebaseFirestore.instance.collection('Transactions');
      QuerySnapshot snapshot =
          await reference.orderBy('Time', descending: true).get();
      print('calling');
      snapshot.docs.forEach((doc) {
        if (FirebaseAuth.instance.currentUser!.email == doc['UserID']) {
          if (widget.size != widget.withdrawMessage.length) {
            setState(() {
              widget.amount.add(doc['Amount']);
              widget.withdrawMessage.add(doc['Bank']);
              widget.withdrawStatus.add(doc['Status']);
              widget.tStatus.add(doc['TStatus']);
              widget.withdrawTimeStamps.add(doc['Time']);
              widget.bankIcon.add(doc['Bank Icon']);
              print('completed');
            });
            print(widget.amount);
            print(widget.withdrawStatus);
            print(widget.withdrawMessage);
            print(widget.withdrawTimeStamps);
            print(widget.bankIcon);
            //print(widget.success);
          }
        }
      });
      setState(() {
        widget.currentUser = FirebaseAuth.instance.currentUser!.email;
        widget.size = widget.withdrawMessage.length;
        widget.withdrawMessage.isNotEmpty
            ? widget.ref = true
            : widget.ref = false;
      });
      return true;
    } on FirebaseException catch (e) {
      print(e.message.toString());
      print('null');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
                right: 10,
                left: 10,
              ),
              child: Container(
                color: Color(0xffF5F5F5),
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'You have balance',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              widget.user.realMoney != null
                                  ? 'Rs. ' + widget.user.realMoney.toString()
                                  : '0',
                              style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  color: Color(0xff54B02F),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            color: Color(0xffECB607),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text(
                                  'Widthdraw',
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Image.asset(
                                  'assets/Icon1.png',
                                  height: 25,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 8,
                top: 8,
              ),
              child: Container(
                alignment: Alignment.topLeft,
                child: Text(
                  'Transaction',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            //CircularProgressIndicator().,
            widget.ref == false
                ? Center(
                    child: Text(
                      'No Transaction Record!',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : SizedBox(
                    height: 1500,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: widget.withdrawMessage.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                            left: 10,
                            right: 10,
                            top: 10,
                          ),
                          child: GestureDetector(
                            onTap: () => setState(() {
                              widget.isTapped = true;
                            }),
                            child: Transactionwidget(
                              bankName: widget.withdrawMessage[index],
                              bankIcon: widget.bankIcon[index],
                              status: widget.withdrawStatus[index],
                              successful: widget.tStatus[index],
                              amount: widget.amount[index],
                              time: widget.withdrawTimeStamps[index],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
