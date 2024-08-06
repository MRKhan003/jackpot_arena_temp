import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jackpot_arena/Screens/gamesScreen.dart';
import 'package:jackpot_arena/Widgets/notificationWidget.dart';

class Notificationscreen extends StatelessWidget {
  const Notificationscreen({super.key});

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
                itemCount: GamesScreen().ListImages.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      top: 10,
                    ),
                    child: NotificationWidget(
                      secondaryColor: Colors.white,
                      contextIcon: Icons.email_outlined,
                      contextIcon2: Icons.mark_email_read_outlined,
                      imageURL: GamesScreen().ListImages[index],
                      contextText: 'New Game Just Launched!',
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
