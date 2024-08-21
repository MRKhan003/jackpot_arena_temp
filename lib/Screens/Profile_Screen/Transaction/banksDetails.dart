import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jackpot_arena/Screens/Profile_Screen/Transaction/transactionDetails.dart';
import 'package:jackpot_arena/Widgets/bankDetailsWidget.dart';

class Banksdetails extends StatefulWidget {
  List<String> bankNames = [];
  List<String> bankLogos = [];
  int size = 100;
  Banksdetails({super.key});

  @override
  State<Banksdetails> createState() => _BanksdetailsState();
}

class _BanksdetailsState extends State<Banksdetails> {
  @override
  void initState() {
    super.initState();
    getBankData();
  }

  getBankData() async {
    try {
      CollectionReference reference =
          FirebaseFirestore.instance.collection('Banks');
      QuerySnapshot snapshot =
          await reference.orderBy('Bank_Name', descending: false).get();
      snapshot.docs.forEach((doc) {
        if (widget.size != widget.bankNames.length) {
          setState(() {
            widget.bankLogos.add(doc['Bank_Icon']);
            widget.bankNames.add(doc['Bank_Name']);
          });
        }
      });
      setState(() {
        widget.size = widget.bankNames.length;
      });
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
            Padding(
              padding: const EdgeInsets.only(
                left: 8,
                top: 8,
              ),
              child: Container(
                alignment: Alignment.topLeft,
                child: Text(
                  'Banks and Wallets',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            widget.bankNames.isEmpty
                ? CircularProgressIndicator()
                : SizedBox(
                    height: 1500,
                    child: ListView.builder(
                      itemCount: widget.bankNames.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Transactiondetails(
                              bankName: widget.bankNames[index],
                              bankIcon: widget.bankLogos[index],
                            ),
                          ),
                        ),
                        child: Bankdetailswidget(
                          widgetContext: widget.bankNames[index],
                          widgetImage: widget.bankLogos[index],
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
