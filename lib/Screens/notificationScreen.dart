import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jackpot_arena/Screens/gamesScreen.dart';
import 'package:jackpot_arena/Widgets/notificationWidget.dart';

class Notificationscreen extends StatefulWidget {
  @override
  State<Notificationscreen> createState() => _NotificationscreenState();
  List<String> message = [];
  List<String> image = [];
  List<DateTime> timeStamps = [];
  List<String> status = [];
  int size = 100;
  String? currentUser;
  bool isTapped = false;
}

class _NotificationscreenState extends State<Notificationscreen> {
  @override
  void initState() {
    _getData();
    super.initState();
  }

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
    } catch (e) {}
  }

  _getData() async {
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
            SizedBox(
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
                          widget.isTapped == true;
                        });
                        setData(
                          widget.message[index],
                        );
                        print('tapped...');
                      },
                      child: NotificationWidget(
                        secondaryColor: Colors.white,
                        contextIcon: widget.isTapped == false &&
                                widget.status[index] == 'unseen'
                            ? Icons.email_outlined
                            : Icons.mark_email_read_outlined,
                        //contextIcon2: Icons.mark_email_read_outlined,
                        imageURL: GamesScreen().ListImages[index],
                        contextText: widget.message[index],
                        status: widget.status[index],
                        isOpened: widget.isTapped,
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
