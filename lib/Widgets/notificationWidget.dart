import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class NotificationWidget extends StatefulWidget {
  String imageURL, contextText;
  String? status;
  IconData? contextIcon, contextIcon2;
  Color secondaryColor;
  int? amount;
  NotificationWidget({
    this.contextIcon,
    required this.imageURL,
    required this.contextText,
    this.contextIcon2,
    this.amount,
    this.status,
    required this.secondaryColor,
  });

  @override
  State<NotificationWidget> createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  bool isOpened = false;
  DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isOpened = true;
        });
      },
      child: Container(
        color: isOpened == false || widget.status == 'Failed'
            ? Color(0xffFFF0E8)
            : widget.secondaryColor,
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
                padding: const EdgeInsets.only(
                  left: 10,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      widget.contextText,
                      textAlign: TextAlign.left,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        textAlign: TextAlign.left,
                        DateFormat('EEEE d, y ').format(now),
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
                  ? Icon(
                      isOpened == false
                          ? widget.contextIcon
                          : widget.contextIcon2,
                    )
                  : Column(
                      children: [
                        Text(
                          widget.amount.toString(),
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: widget.status == 'Completed' ||
                                    isOpened != false
                                ? Color(0xff54B02F)
                                : Colors.red,
                          ),
                        ),
                        Text(
                          isOpened == false
                              ? widget.status!
                              : widget.status = 'Completed',
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            color: Colors.black,
                          ),
                        )
                      ],
                    )
            ],
          ),
        ),
      ),
    );
  }
}
