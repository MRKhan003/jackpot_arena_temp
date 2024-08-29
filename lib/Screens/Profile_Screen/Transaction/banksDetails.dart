import 'package:animated_search_bar/animated_search_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jackpot_arena/Screens/Profile_Screen/Transaction/transactionDetails.dart';
import 'package:jackpot_arena/Widgets/bankDetailsWidget.dart';

class Banksdetails extends StatefulWidget {
  List<String> bankNames = [];
  List<String> bankLogos = [];
  //List<String> urls = [];
  int size = 100;
  int logoSize = 100;
  //late String imageUrl;
  String downloadURL = '';
  bool testing = false;
  TextEditingController searchController = TextEditingController();
  List<String> filteredItem = [];
  List<String> filteredLogo = [];
  Banksdetails({super.key});

  @override
  State<Banksdetails> createState() => _BanksdetailsState();
}

class _BanksdetailsState extends State<Banksdetails> {
  @override
  void initState() {
    getBankData();
    loadImages();
    super.initState();
  }

  loadImages() async {
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      ListResult result = await storage.ref('BankIcons/').listAll();
      if (widget.bankLogos.isEmpty) {
        for (var ref in result.items) {
          widget.downloadURL = await ref.getDownloadURL();
          setState(() {
            widget.bankLogos.add(widget.downloadURL);
          });
        }
        setState(() {
          //widget.bankLogos = widget.urls;
          widget.logoSize = widget.bankLogos.length;
          //widget.testing = true;
          //isLoading = false;
        });
        widget.bankLogos.sort();
        setState(() {
          widget.filteredLogo = widget.bankLogos;
        });
        print(widget.bankLogos);
      }
    } catch (e) {
      print(e.toString);
    }
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
            //widget.bankLogos.add(doc['Bank_Icon']);
            widget.bankNames.add(doc['Bank_Name']);
          });
        }
      });
      setState(() {
        widget.size = widget.bankNames.length;
        widget.filteredItem = widget.bankNames;
      });
      //loadImages();
      print(widget.bankNames);
    } on FirebaseException catch (e) {
      print(e.message);
    }
  }

  void _filterItems() {
    setState(() {
      widget.testing = true;
    });
    List<String> results = [];
    List<String> logoResult = [];
    if (widget.searchController.text.isEmpty) {
      results = widget.bankNames;
      logoResult = widget.bankLogos;
    } else {
      results = widget.bankNames
          .where((item) => item
              .toLowerCase()
              .contains(widget.searchController.text.toLowerCase()))
          .toList();
      logoResult = widget.bankLogos
          .where((items) => items
              .toLowerCase()
              .contains(widget.searchController.text.toLowerCase()))
          .toList();
    }

    setState(() {
      widget.filteredItem = results;
      widget.filteredLogo = logoResult;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 30,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      body: Column(
        children: [
          // widget.testing == true
          //     ? SizedBox()
          //     : Padding(
          //         padding: const EdgeInsets.only(
          //           left: 8,
          //           top: 8,
          //         ),
          //         child: Container(
          //           alignment: Alignment.topLeft,
          //           child: Text(
          //             'Banks and Wallets',
          //             style: GoogleFonts.poppins(
          //               fontSize: 18,
          //               color: Colors.black,
          //             ),
          //           ),
          //         ),
          //       ),
          Padding(
            padding: const EdgeInsets.only(
              left: 8,
              top: 16,
            ),
            child: AnimatedSearchBar(
              //height: 40,
              label: 'Banks and Wallets',
              //labelAlignment: Alignment.topLeft,
              labelTextAlign: TextAlign.start,
              labelStyle: GoogleFonts.poppins(
                fontSize: 18,
                color: Colors.black,
              ),
              controller: widget.searchController,
              //labelAlignment: Alignment.topRight,
              onChanged: (p0) {
                _filterItems();
              },
              //label: 'Search',
              cursorColor: Colors.black26,
              searchDecoration: InputDecoration(
                label: Text('Search'),
                labelStyle: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.black26,
                ),
                floatingLabelAlignment: FloatingLabelAlignment.start,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xffEFCC4E),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xffEFCC4E),
                  ),
                ),
              ),
            ),
          ),
          widget.bankLogos.length != widget.bankNames.length
              ? CircularProgressIndicator(
                  color: Color(
                    0xffEFCC4E,
                  ),
                )
              : Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: widget.filteredItem.length,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Transactiondetails(
                            bankName: widget.filteredItem[index],
                            bankIcon: widget.filteredLogo[index],
                          ),
                        ),
                      ),
                      child: Bankdetailswidget(
                        widgetContext: widget.filteredItem[index],
                        widgetImage: widget.filteredLogo[index],
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
