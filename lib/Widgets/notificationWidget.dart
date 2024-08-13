import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class NotificationWidget extends StatefulWidget {
  String imageURL, contextText;
  String? status;
  IconData? contextIcon, contextIcon2;
  Color? secondaryColor;
  String? amount;
  bool isOpened;
  Object? isSuccessfull;
  Timestamp? time;
  NotificationWidget({
    this.contextIcon,
    this.isSuccessfull,
    required this.isOpened,
    required this.imageURL,
    required this.contextText,
    this.time,
    this.contextIcon2,
    this.amount,
    this.status,
    this.secondaryColor,
  });

  @override
  State<NotificationWidget> createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      color:
          widget.status == 'unseen' ? Color(0xffFFF0E8) : widget.secondaryColor,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            CircleAvatar(
              foregroundImage: AssetImage(
                widget.imageURL,
              ),
              maxRadius: 20,
              minRadius: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      widget.contextText,
                      textAlign: TextAlign.left,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      textAlign: TextAlign.start,
                      DateFormat('EEEE d, y ').format(
                        widget.time != null ? widget.time!.toDate() : now,
                      ),
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Color(0xffb959595),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            widget.amount == null
                ? Icon(widget.contextIcon)
                : Column(
                    children: [
                      Text(
                        widget.amount.toString(),
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: widget.status == 'Completed'
                              ? Color(0xff54B02F)
                              : Colors.red,
                        ),
                      ),
                      Text(
                        widget.isSuccessfull == true ? 'Completed' : 'Failed',
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
