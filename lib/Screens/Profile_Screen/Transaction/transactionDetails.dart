import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jackpot_arena/Controllers/transactionController.dart';
import 'package:jackpot_arena/Firebase/userDetails.dart';

class Transactiondetails extends StatefulWidget {
  String bankName;
  String bankIcon;
  UserDetails userDetails = UserDetails();
  final Transactioncontroller transactioncontroller = Transactioncontroller();
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    getCurrentUser();
    getData();
    super.initState();
  }

  String? _validateAccountNumber(String? value) {
    // Logic to determine valid lengths based on selected bank
    if (widget.bankName == 'JS Bank') {
      if (value!.length != 4) {
        return 'Account number must be 4 characters long for ${widget.bankName}';
      }
    } else if (widget.bankName == 'Jazz Cash' ||
        widget.bankName == 'NayaPay' ||
        widget.bankName == 'SadaPay' ||
        widget.bankName == 'EasyPaisa' ||
        widget.bankName == 'Upaisa') {
      if (value!.length != 11) {
        return 'Account number must be 11 characters long for ${widget.bankName}';
      }
    } else {
      if (value!.length != 14) {
        return 'Account number must be 14 characters long for ${widget.bankName}';
      }
    }
    return null; // Return null if validation passes
  }

  String? _validateAccountTitle(String? accountTitle) {
    if (accountTitle == null || accountTitle.contains(RegExp(r'[0-9]'))) {
      return 'Please enter correct account title';
    } else {
      return null;
    }
  }

  String? _validateAmount(String? amount) {
    if (widget.userDetails.realMoney!.isLowerThan(int.parse(amount!))) {
      return 'Amount must be between 1-${widget.userDetails.realMoney}';
    } else
      return null;
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
          .doc(FirebaseAuth.instance.currentUser!.uid)
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
      print(
        e.message.toString(),
      );
      return false;
    }
  }

  getData() async {
    try {
      CollectionReference getDataReference = FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('Earning');
      QuerySnapshot snapshot = await getDataReference.get();
      snapshot.docs.forEach((doc) {
        setState(() {
          widget.userDetails.realMoney = doc['Real Money'];
        });
      });

      return true;
    } on FirebaseException catch (e) {
      print(
        e.message.toString(),
      );
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
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      cursorColor: Colors.black26,
                      initialValue: widget.bankName,
                      readOnly: true,
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xffEFCC4E),
                          ),
                        ),
                        labelText: 'Bank Name',
                        floatingLabelStyle: TextStyle(
                          color: Color(0xffEFCC4E),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                    ),
                    TextFormField(
                      cursorColor: Colors.black26,
                      controller:
                          widget.transactioncontroller.accountNumberController,
                      keyboardType: TextInputType.number,
                      readOnly: false,
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xffEFCC4E),
                          ),
                        ),
                        labelText: 'Account Number/Mobile Number',
                        floatingLabelStyle: TextStyle(
                          color: Color(0xffEFCC4E),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        //errorMaxLines: 14,
                      ),
                      maxLength: widget.bankName == 'Jazz Cash' ||
                              widget.bankName == 'NayaPay' ||
                              widget.bankName == 'SadaPay' ||
                              widget.bankName == 'EasyPaisa' ||
                              widget.bankName == 'Upaisa'
                          ? 11
                          : widget.bankName == 'JS Bank'
                              ? 4
                              : 14,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      validator: _validateAccountNumber,
                    ),
                    TextFormField(
                      cursorColor: Colors.black26,
                      controller: widget.transactioncontroller.nameController,
                      keyboardType: TextInputType.name,
                      spellCheckConfiguration: SpellCheckConfiguration(
                        spellCheckService: DefaultSpellCheckService(),
                      ),
                      readOnly: false,
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xffEFCC4E),
                          ),
                        ),
                        labelText: 'Account Title',
                        floatingLabelStyle: TextStyle(
                          color: Color(0xffEFCC4E),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                      validator: _validateAccountTitle,
                    ),
                    TextFormField(
                      cursorColor: Colors.black26,
                      controller: widget.transactioncontroller.amountController,
                      keyboardType: TextInputType.number,
                      readOnly: false,
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xffEFCC4E),
                          ),
                        ),
                        labelText: 'Amount',
                        floatingLabelStyle: TextStyle(
                          color: Color(0xffEFCC4E),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                      validator: _validateAmount,
                      onFieldSubmitted: (amountValue) {
                        amountValue = '';
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          Color(0xffEFCC4E),
                        ),
                      ),
                      onPressed: () {
                        print(
                          widget.transactioncontroller.accountNumberController
                              .text,
                        );
                        if (_formKey.currentState!.validate()) {
                          setTransactionData(
                            widget.bankName,
                            widget.transactioncontroller.accountNumberController
                                .text,
                            int.parse(widget
                                .transactioncontroller.amountController.text),
                            widget.transactioncontroller.nameController.text,
                            widget.bankIcon,
                          );
                          widget.transactioncontroller.nameController.clear();
                          widget.transactioncontroller.accountNumberController
                              .clear();
                          widget.transactioncontroller.amountController.clear();
                          setState(() {
                            widget.checking = 1;
                          });
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
                      child: Text(
                        'Submit',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
