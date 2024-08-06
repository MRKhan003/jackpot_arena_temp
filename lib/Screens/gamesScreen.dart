import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:jackpot_arena/Widgets/homeScreenCard.dart';

class GamesScreen extends StatefulWidget {
  @override
  State<GamesScreen> createState() => _GamesScreenState();
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
}

class _GamesScreenState extends State<GamesScreen> {
  TextEditingController searchController = TextEditingController();

  CarouselController carouselController = CarouselController();
  BannerAd? _bannerAd;
  static final BannerAdListener bannerAdListener = BannerAdListener(
    onAdLoaded: (ad) => debugPrint('ad loaded'),
    onAdFailedToLoad: (ad, error) {
      ad.dispose();
      debugPrint(
          '--------------------------------------------Failed to load, $error');
    },
    onAdOpened: (ad) => debugPrint('Ad Opened'),
    onAdClosed: (ad) => debugPrint('Ad Closed'),
  );
  void _createBannerAd() {
    print(
        '--------------helloooooooooooooooooooooooooo _createBannerAd------------');
    _bannerAd = BannerAd(
        size: AdSize.fullBanner,
        adUnitId: "ca-app-pub-3940256099942544/2247696110",
        listener: bannerAdListener,
        request: AdRequest())
      ..load();
  }

  void initstate() {
    super.initState();
    _createBannerAd();
  }

  List<String> CategoryImage = [
    'assets/Arcade.png',
    'assets/Cricket.png',
    'assets/Arcade.png',
    'assets/Cricket.png',
  ];

  // List<String> CategoryText = [
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
                backgroundColor: WidgetStatePropertyAll(Color(0xffF0F0F0)),
                elevation: WidgetStatePropertyAll(0),
                surfaceTintColor: WidgetStatePropertyAll(Colors.white),
                side:
                    WidgetStatePropertyAll(BorderSide(style: BorderStyle.none)),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(),
                ),
                hintText: 'Search',
                leading: Icon(Icons.search),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CarouselSlider(
              carouselController: carouselController,
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
                height: 200,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <IconButton>[
                IconButton(
                  alignment: Alignment.center,
                  splashRadius: 1,
                  style: ButtonStyle(
                    iconSize: WidgetStatePropertyAll(1),
                    padding: WidgetStatePropertyAll(
                      EdgeInsets.all(
                        0,
                      ),
                    ),
                  ),
                  onPressed: () => carouselController.previousPage(
                    duration: Duration(
                      seconds: 1,
                    ),
                  ),
                  icon: Icon(
                    Icons.circle,
                    size: 10,
                  ),
                ),
                IconButton(
                  alignment: Alignment.center,
                  splashRadius: 1,
                  style: ButtonStyle(
                    iconSize: WidgetStatePropertyAll(1),
                    padding: WidgetStatePropertyAll(
                      EdgeInsets.all(
                        0,
                      ),
                    ),
                  ),
                  onPressed: () => carouselController.nextPage(
                    duration: Duration(
                      seconds: 1,
                    ),
                  ),
                  icon: Icon(
                    Icons.circle,
                    size: 10,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40),
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
            SizedBox(
              height: 130,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: HomeCard(
                      cardImage: widget.ListImages[index],
                      cardText: widget.ListText[index],
                      index: index,
                    ),
                  );
                },
                itemCount: widget.ListText.length,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: _bannerAd == null
                    ? Image.asset(
                        'assets/Frame.jpg',
                        filterQuality: FilterQuality.high,
                        fit: BoxFit.fill,
                      )
                    : AdWidget(ad: _bannerAd!),
                //height: 70,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40),
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
                    padding: const EdgeInsets.only(
                      left: 40,
                      right: 10,
                      bottom: 5,
                    ),
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
      // bottomNavigationBar:
      //     _bannerAd == null ? Container() : AdWidget(ad: _bannerAd!),
    );
  }
}
