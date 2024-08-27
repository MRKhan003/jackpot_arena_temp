import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jackpot_arena/Controllers/transactionController.dart';
import 'package:jackpot_arena/Firebase/userDetails.dart';

class Transactiondetails extends StatefulWidget {
  String bankName;
  String bankIcon;
  UserDetails userDetails = UserDetails();
  Transactioncontroller transactioncontroller = Transactioncontroller();
  int userAmount = 0;
  int checking = 0;
  bool? validate;
  bool? accountValueValidate;
  bool? displayValueValidate;
  bool? amountValueValidate;
  Transactiondetails({
    required this.bankName,
    required this.bankIcon,
  });

  @override
  State<Transactiondetails> createState() => _TransactiondetailsState();
}

class _TransactiondetailsState extends State<Transactiondetails> {
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    getCurrentUser();
    getData();
  }

  updateData() async {
    //UserDetails setUser = UserDetails();
    setState(() {
      widget.userDetails.realMoney =
          widget.userDetails.realMoney! - widget.userAmount;
    });
    try {
      print(widget.userDetails.realMoney);
      print(widget.userAmount);
      print(FirebaseAuth.instance.currentUser!.uid);
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(widget.userDetails.email)
          .collection('Earning')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        'Real Money': widget.userDetails.realMoney,
      });

      print(
        widget.transactioncontroller.amountController.text,
      );
      return true;
    } on FirebaseException catch (e) {
      Fluttertoast.showToast(
        msg: e.message.toString(),
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 10,
        backgroundColor: Color(0xffF8F8F8),
        textColor: Colors.red,
        fontSize: 16.0,
      );
      print(e.message.toString());
      return false;
    }
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
      final email = await FirebaseAuth.instance.currentUser!.email;
      setState(() {
        widget.userDetails.email = email;
      });

      print(widget.userDetails.email);
    } catch (e) {
      print(e);
    }
  }

  setTransactionData(String bankName, String accountNumber, int amount,
      String displayName, String bankIcon) async {
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
        'Bank Icon': bankIcon,
        'RefundStatus': '',
        'Reason': '',
      });
      Fluttertoast.showToast(
        msg: 'Request Sent',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Color(0xffF8F8F8),
        textColor: Colors.green,
        fontSize: 16.0,
      );
      updateData();
    } on FirebaseException catch (e) {
      print(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: CircleAvatar(
                foregroundColor: Colors.white,
                backgroundColor: Colors.white,
                foregroundImage: NetworkImage(
                  widget.bankIcon,
                ),
                maxRadius: 50,
                minRadius: 40,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Form(
                autovalidateMode: widget.checking == 0
                    ? AutovalidateMode.onUserInteraction
                    : AutovalidateMode.disabled,
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: widget.bankName,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'Bank Name',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                    ),
                    TextFormField(
                      onChanged: (accountValue) {
                        if (accountValue.isEmpty) {
                          setState(() {
                            widget.accountValueValidate = false;
                          });
                        } else if (accountValue.length != 14) {
                          setState(() {
                            widget.accountValueValidate = false;
                          });
                        } else {
                          setState(() {
                            widget.accountValueValidate = true;
                          });
                        }
                      },
                      controller:
                          widget.transactioncontroller.accountNumberController,
                      keyboardType: TextInputType.name,
                      readOnly: false,
                      decoration: InputDecoration(
                        labelText: 'Account Number/Mobile Number',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        //errorMaxLines: 14,
                      ),
                      maxLength: widget.bankName == 'Jazz Cash' ||
                              widget.bankName == 'NayaPay' ||
                              widget.bankName == 'SadaPay' ||
                              widget.bankName == 'EasyPaisa'
                          ? 11
                          : 14,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      // Set maximum length to 14 digits
                      validator: (accountValue) {
                        if (accountValue!.isEmpty &&
                            widget.accountValueValidate == false) {
                          return 'Please enter account number';
                        }
                        if (accountValue.length < 11 ||
                            accountValue.length > 14 &&
                                widget.accountValueValidate == false) {
                          if (widget.bankName == 'Jazz Cash' ||
                              widget.bankName == 'NayaPay' ||
                              widget.bankName == 'SadaPay' ||
                              widget.bankName == 'EasyPaisa') {
                            return 'Account number should be of 11 digits';
                          } else
                            return 'Account number should be between of 14 digits';
                        }
                        // Additional validation if needed
                        return null; // Return null if validation passes
                      },
                    ),
                    TextFormField(
                      onChanged: (displayValue) {
                        if (displayValue.isEmpty) {
                          setState(() {
                            widget.displayValueValidate = false;
                          });
                        } else {
                          setState(() {
                            widget.displayValueValidate = true;
                          });
                        }
                      },
                      controller: widget.transactioncontroller.nameController,
                      keyboardType: TextInputType.name,
                      spellCheckConfiguration: SpellCheckConfiguration(
                        spellCheckService: DefaultSpellCheckService(),
                      ),
                      readOnly: false,
                      decoration: InputDecoration(
                        labelText: 'Display Name',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                      validator: (displayValue) {
                        if (displayValue!.isEmpty &&
                            widget.displayValueValidate == false) {
                          return 'Please enter account display name';
                        }

                        // Additional validation if needed
                        return null; // Return null if validation passes
                      },
                    ),
                    TextFormField(
                      onChanged: (amountValue) {
                        if (amountValue.isEmpty) {
                          setState(() {
                            widget.amountValueValidate = false;
                          });
                        } else if (amountValue == "0") {
                          widget.amountValueValidate = false;
                        } else {
                          setState(() {
                            widget.amountValueValidate = true;
                            widget.userAmount = int.parse(amountValue);
                          });
                        }
                      },
                      controller: widget.transactioncontroller.amountController,
                      keyboardType: TextInputType.number,
                      readOnly: false,
                      decoration: InputDecoration(
                        labelText: 'Amount',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                      validator: (amountValue) {
                        if (amountValue!.isEmpty &&
                            widget.amountValueValidate == false) {
                          return 'Please enter a valid amount';
                        } else if (amountValue == '0' &&
                            widget.amountValueValidate == false) {
                          return 'Please select a amount between 1 - ${widget.userDetails.realMoney}';
                        }

                        // Additional validation if needed
                        return null; // Return null if validation passes
                      },
                      onFieldSubmitted: (amountValue) {
                        amountValue = '';
                      },
                    ),
                  ],
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
                        .transactioncontroller.nameController.text.isNotEmpty &&
                    widget.userDetails.realMoney! >=
                        int.parse(
                          widget.transactioncontroller.amountController.text,
                        ) &&
                    int.parse(
                          widget.transactioncontroller.amountController.text,
                        ) !=
                        0 &&
                    widget.transactioncontroller.accountNumberController.text
                            .length >=
                        11 &&
                    widget.transactioncontroller.accountNumberController.text
                            .length <=
                        14) {
                  setTransactionData(
                    widget.bankName,
                    widget.transactioncontroller.accountNumberController.text,
                    int.parse(
                        widget.transactioncontroller.amountController.text),
                    widget.transactioncontroller.nameController.text,
                    widget.bankIcon,
                  );
                  widget.transactioncontroller.nameController.clear();
                  widget.transactioncontroller.accountNumberController.clear();
                  widget.transactioncontroller.amountController.clear();
                  setState(() {
                    widget.checking = 1;
                  });
                  //_formKey.currentState!.reset();
                  //widget.transactioncontroller.accountNumberController == 0;
                } else {
                  Fluttertoast.showToast(
                    msg: 'Recheck your information and try again!',
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 3,
                    backgroundColor: Color(0xffF8F8F8),
                    textColor: Colors.red,
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
