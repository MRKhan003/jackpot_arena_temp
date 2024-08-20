import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class Transactionwidget extends StatelessWidget {
  String bankName, bankIcon, amount, successful, status;

  Timestamp time;
  Transactionwidget({
    required this.bankName,
    required this.bankIcon,
    required this.status,
    required this.successful,
    required this.amount,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: successful == 'Failed' || successful == 'failed'
          ? Color(0xffFFF0E8)
          : successful == 'Inprogress' || successful == 'In-Progress'
              ? Color(0xffFFFFE0)
              : Color(0xffF1FFEC),
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            CircleAvatar(
              foregroundImage: NetworkImage(
                bankIcon,
              ),
              maxRadius: 30,
              minRadius: 25,
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
                      bankName,
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
                        time.toDate(),
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
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Rs. ',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        amount,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: successful == 'Completed'
                              ? Color(0xff54B02F)
                              : successful == 'In-Progress' ||
                                      successful == 'Inprogress'
                                  ? Colors.black
                                  : Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    successful,
                    style: GoogleFonts.poppins(
                      fontSize: 10,
                      color: Colors.black,
                    ),
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
