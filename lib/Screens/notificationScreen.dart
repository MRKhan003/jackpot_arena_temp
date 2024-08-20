import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jackpot_arena/Widgets/notificationWidget.dart';

class Notificationscreen extends StatefulWidget {
  List<String> message = [];
  List<String> image = [];
  List<Timestamp> timeStamps = [];
  List<String> status = [];
  int size = 100;
  String? currentUser;
  static bool isTapped = false;
  int notificationCount = 100;
  bool ref = true;
  Notificationscreen({super.key});
  @override
  State<Notificationscreen> createState() => _NotificationscreenState();
}

class _NotificationscreenState extends State<Notificationscreen> {
  @override
  void initState() {
    _getData();
    //loadItems();
    super.initState();
  }

  // loadItems() {
  //   if (widget.message.isEmpty) {
  //     setState(() {
  //       widget.ref = false;
  //     });
  //   } else {
  //     setState(() {
  //       widget.ref = true;
  //     });
  //   }
  // }

  Future<void> setData(String docName) async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('Notifications').get();
      print('Loading...');
      snapshot.docs.forEach((doc) {
        if (doc['Title'] == docName) {
          doc.reference.update({'Status': 'Seen'});
        } else {
          print('Error');
        }
      });
      _updateNotifications();
      //getNotificationCount();
    } catch (e) {}
  }

  _getData() async {
    try {
      CollectionReference reference =
          FirebaseFirestore.instance.collection('Notifications');
      QuerySnapshot snapshot = await reference
          .orderBy(
            'Time',
            descending: true,
          )
          .get();
      print('calling');
      snapshot.docs.forEach((doc) {
        if (FirebaseAuth.instance.currentUser!.email == doc['UserID']) {
          if (widget.size != widget.message.length) {
            setState(() {
              widget.message.add(doc['Title']);
              widget.image.add(doc['Image Path']);
              widget.status.add(doc['Status']);
              widget.timeStamps.add(doc['Time']);
              print('added');
            });
          }
        }
      });
      setState(() {
        widget.currentUser = FirebaseAuth.instance.currentUser!.email;
        widget.size = widget.message.length;
        widget.message.isNotEmpty ? widget.ref = true : widget.ref = false;
      });
      return true;
    } on FirebaseException catch (e) {
      print(e.message.toString());
      print('null');
      return false;
    }
  }

  _updateNotifications() async {
    widget.message = [];
    widget.status = [];

    try {
      CollectionReference reference =
          FirebaseFirestore.instance.collection('Notifications');
      QuerySnapshot snapshot = await reference.get();
      print('calling');
      snapshot.docs.forEach((doc) {
        if (FirebaseAuth.instance.currentUser!.email == doc['UserID']) {
          if (widget.size != widget.message.length) {
            setState(() {
              widget.message.add(doc['Title']);
              widget.image.add(doc['Image Path']);
              widget.status.add(doc['Status']);
              print('added');
            });
          }
        }
      });
      setState(() {
        widget.currentUser = FirebaseAuth.instance.currentUser!.email;
        widget.size = widget.message.length;
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
                left: 8,
                top: 8,
              ),
              child: Container(
                alignment: Alignment.topLeft,
                child: Text(
                  'Notifications',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            widget.ref == false
                ? SizedBox(
                    height: 100,
                    child: Center(
                      child: Text(
                        'No Notifications!',
                        textAlign: TextAlign.end,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          //fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  )
                : SizedBox(
                    height: 1500,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: widget.message.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                            left: 10,
                            right: 10,
                            top: 10,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                Notificationscreen.isTapped == true;
                              });
                              setData(
                                widget.message[index],
                              );

                              print('tapped...');
                            },
                            child: NotificationWidget(
                              secondaryColor: Colors.white,
                              //contextIcon2: Icons.mark_email_read_outlined,
                              imageURL: widget.image[index],
                              contextText: widget.message[index],
                              status: widget.status[index],
                              isOpened: Notificationscreen.isTapped,
                              contextIcon: widget.status[index] == 'unseen'
                                  ? Icons.email_outlined
                                  : Icons.mark_email_read_outlined,
                              time: widget.timeStamps[index],
                              amount: null,
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
