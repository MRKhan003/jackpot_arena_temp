import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jackpot_arena/Firebase/userDetails.dart';
import 'package:jackpot_arena/Screens/Profile_Screen/Transaction/banksDetails.dart';
import 'package:jackpot_arena/Widgets/transactionWidget.dart';

class Withdrawhistoryscreen extends StatefulWidget {
  UserDetails user = UserDetails();
  bool isTapped = false;
  List<String> withdrawMessage = [];
  List<String> tStatus = [];
  List<Timestamp> withdrawTimeStamps = [];
  List<String> withdrawStatus = [];
  List<int> amount = [];
  List<String> bankIcon = [];
  List<String> summary = [];
  bool ref = true;
  int size = 100;
  List<String> getLength = [];
  String? currentUser;
  int running = 0;
  Withdrawhistoryscreen({super.key});
  @override
  State<Withdrawhistoryscreen> createState() => _WithdrawhistoryscreenState();
}

class _WithdrawhistoryscreenState extends State<Withdrawhistoryscreen> {
  @override
  void initState() {
    getData();
    _getTransactionData();
    getLength();
    setData();
    super.initState();
  }

  ScrollController scrollController = ScrollController();
  showDialogBox(String failedText, int index) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return AlertDialog(
          scrollable: true,
          alignment: Alignment.center,
          backgroundColor: widget.tStatus[index] == 'Completed' ||
                  widget.tStatus[index] == 'completed'
              ? Color(0xff90EE90)
              : Colors.red,
          shape: BeveledRectangleBorder(),
          title: Text(
            widget.tStatus[index] == 'Completed' ||
                    widget.tStatus[index] == 'completed'
                ? 'Transaction Success Details'
                : 'Transaction Failure Reason',
            style: GoogleFonts.poppins(
              fontSize: 18,
              color: widget.tStatus[index] == 'Completed' ||
                      widget.tStatus[index] == 'completed'
                  ? Colors.black
                  : Colors.white,
            ),
          ),
          content: Text(
            failedText,
            textAlign: TextAlign.left,
            style: GoogleFonts.poppins(
              color: widget.tStatus[index] == 'Completed' ||
                      widget.tStatus[index] == 'completed'
                  ? Colors.black
                  : Colors.white,
              fontSize: 14,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.pop(context, 'Cancel');
              },
              child: Text(
                'Continue',
                style: GoogleFonts.poppins(
                  color: widget.tStatus[index] == 'Completed' ||
                          widget.tStatus[index] == 'completed'
                      ? Colors.black
                      : Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
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

  getLength() async {
    setState(() {
      widget.getLength = [];
    });

    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('Transactions').get();
      querySnapshot.docs.forEach((doc) {
        if (FirebaseAuth.instance.currentUser!.email == doc['UserID']) {
          setState(() {
            widget.getLength.add(
              doc['Bank'],
            );
          });
        }
      });
    } catch (e) {
      print(e);
    }
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
          if (widget.withdrawMessage.length != widget.size) {
            setState(() {
              widget.amount.add(doc['Amount']);
              widget.withdrawMessage.add(doc['Bank']);
              widget.withdrawStatus.add(doc['Status']);
              widget.tStatus.add(doc['TStatus']);
              widget.withdrawTimeStamps.add(doc['Time']);
              widget.bankIcon.add(doc['Bank Icon']);
              widget.summary.add(doc['Reason']);
              print('completed');
            });
            print(widget.amount);
            print(widget.withdrawStatus);
            print(widget.withdrawMessage);
            print(widget.withdrawTimeStamps);
            print(widget.bankIcon);
            print(widget.summary);
            //print(widget.success);
          }
        }
      });
      setState(() {
        widget.currentUser = FirebaseAuth.instance.currentUser!.email;
        widget.size = widget.bankIcon.length;
        widget.withdrawMessage.isNotEmpty
            ? widget.ref = true
            : widget.ref = false;
        widget.running = 1;
      });
      return true;
    } on FirebaseException catch (e) {
      print(e.message.toString());
      print('null');
      return false;
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
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
                      child: GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Banksdetails(),
                          ),
                        ),
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
          widget.running == 0
              ? CircularProgressIndicator(
                  color: Color(0xffEFCC4E),
                )
              : widget.ref == false
                  ? Center(
                      child: Text(
                        //gettingData(),
                        'No Transaction Record!',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: widget.tStatus.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                              left: 10,
                              right: 10,
                              top: 10,
                              bottom: 10,
                            ),
                            child: GestureDetector(
                              onTap: () => setState(() {
                                widget.isTapped = true;
                                widget.tStatus[index] == 'Failed' ||
                                        widget.tStatus[index] == 'failed' ||
                                        widget.tStatus[index] == 'Completed' ||
                                        widget.tStatus[index] == 'completed'
                                    ? showDialogBox(
                                        widget.summary[index],
                                        index,
                                      )
                                    : null;
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
    );
  }
}
