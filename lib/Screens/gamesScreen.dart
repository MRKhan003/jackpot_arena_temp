import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jackpot_arena/Widgets/homeScreenCard.dart';

class GamesScreen extends StatelessWidget {
  List<String> ListImages = [
    'assets/Plane Crash.png',
    'assets/Dice.png',
    'assets/Plink.png',
  ];
  List<String> ListText = [
    'Plane Crash \n Game',
    'Dice Money \n Cash',
    'Plink',
  ];
  List<String> CategoryImage = [
    'assets/Snooker.png',
    'assets/Sports.png',
  ];
  List<String> CategoryText = [
    'Arcade',
    'Sports',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: SearchBar(
                hintText: 'Search',
                leading: Icon(Icons.search),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            CarouselSlider(
              items: [
                Image.asset(
                  'assets/Carousel-1.png',
                  filterQuality: FilterQuality.high,
                ),
                Image.asset(
                  'assets/Carousel-2.png',
                  filterQuality: FilterQuality.high,
                ),
              ],
              options: CarouselOptions(autoPlay: true),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Games',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: HomeCard(
                      cardImage: ListImages[index],
                      cardText: ListText[index],
                      index: index,
                    ),
                  );
                },
                itemCount: ListText.length,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Categories',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: HomeCard(
                      cardImage: CategoryImage[index],
                      cardText: CategoryText[index],
                      index: index,
                    ),
                  );
                },
                itemCount: CategoryImage.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
