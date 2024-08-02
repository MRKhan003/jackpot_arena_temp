import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jackpot_arena/Widgets/customSearchBar.dart';
import 'package:jackpot_arena/Widgets/homeScreenCard.dart';
import 'package:jackpot_arena/Widgets/inputField.dart';

class GamesScreen extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();
  List<String> ListImages = [
    'assets/Plane Crash.png',
    'assets/Dice.png',
    'assets/Plink.png',
    'assets/Plane Crash.png',
    'assets/Dice.png',
    'assets/Plink.png',
  ];
  List<String> ListText = [
    'Plane Crash \n Game',
    'Dice Money \n Cash',
    'Plinko',
    'Plane Crash \n Game',
    'Dice Money \n Cash',
    'Plinko',
  ];
  List<String> CategoryImage = [
    'assets/Arcade.png',
    'assets/Cricket.png',
    'assets/Arcade.png',
    'assets/Cricket.png',
  ];
  // List<String> CategoryText = [
  //   'Arcade',
  //   'Sports',
  // ];
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
            Padding(
              padding: EdgeInsets.only(
                left: 15,
                right: 15,
              ),
              child: CustomSearchBar(
                fieldText: '',
                textController: _searchController,
                keyboardType: TextInputType.text,
                hideText: false,
                fieldIcon: Icons.settings,
              ),
            ),
            // const Padding(
            //   padding: EdgeInsets.only(left: 15, right: 15),
            //   child: SearchBar(
            //     backgroundColor: WidgetStatePropertyAll(Color(0xffF0F0F0)),
            //     elevation: WidgetStatePropertyAll(1),
            //     surfaceTintColor: WidgetStatePropertyAll(Colors.white),
            //     side:
            //         WidgetStatePropertyAll(BorderSide(style: BorderStyle.none)),
            //     hintText: 'Search',
            //     leading: Icon(Icons.search),
            //   ),
            // ),
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
              options: CarouselOptions(
                autoPlay: true,
                enlargeCenterPage: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Games',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
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
              padding: const EdgeInsets.only(left: 37),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Categories',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 30, right: 10),
                    child: Container(
                      //height: 200,
                      child: Image.asset(
                        CategoryImage[index],
                        height: 500,
                      ),
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
