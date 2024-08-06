import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jackpot_arena/Screens/gamesScreen.dart';
import 'package:jackpot_arena/Widgets/notificationWidget.dart';

class Withdrawhistoryscreen extends StatefulWidget {
  const Withdrawhistoryscreen({super.key});

  @override
  State<Withdrawhistoryscreen> createState() => _WithdrawhistoryscreenState();
}

class _WithdrawhistoryscreenState extends State<Withdrawhistoryscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
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
                              'Rs. 5,000',
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
            SizedBox(
              height: 1500,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: GamesScreen().ListImages.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      top: 10,
                    ),
                    child: NotificationWidget(
                      secondaryColor: Color(0xffF1FFEC),
                      amount: 100,
                      status: 'Failed',
                      imageURL: 'assets/jazz.png',
                      contextText: 'JazzCash - Mobilink',
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
