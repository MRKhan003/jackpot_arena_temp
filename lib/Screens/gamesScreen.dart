import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:jackpot_arena/Widgets/homeScreenCard.dart';
import 'package:jackpot_arena/Widgets/searchItems.dart';

class GamesScreen extends StatefulWidget {
  GamesScreen({super.key});
  @override
  State<GamesScreen> createState() => _GamesScreenState();
  List<Searchitems> searchList = allItems;
  bool isActive = true;
  bool addLoaded = false;

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
  bool isTapped = false;
  bool inSearch = false;
}

class _GamesScreenState extends State<GamesScreen> {
  bool _whenTapped() {
    setState(() {
      widget.isTapped = true;
      widget.inSearch = true;
    });
    return widget.isTapped;
  }

  bool _whenTappedOutside() {
    setState(() {
      widget.isTapped = false;
    });
    return widget.isTapped;
  }

  bool _inSearchBox() {
    setState(() {
      widget.inSearch = true;
    });

    return widget.inSearch;
  }

  TextEditingController searchController = TextEditingController();

  String? selectedValue;
  final TextEditingController textEditingController = TextEditingController();
  CarouselSliderController carouselController = CarouselSliderController();
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
  @override
  void initState() {
    _createBannerAd();
    super.initState();
  }

  _createBannerAd() {
    print(
        '--------------helloooooooooooooooooooooooooo _createBannerAd------------');
    _bannerAd = BannerAd(
        size: AdSize.getInlineAdaptiveBannerAdSize(400, 80),
        adUnitId: "ca-app-pub-3940256099942544/6300978111",
        listener: bannerAdListener,
        request: AdRequest())
      ..load();
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
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: SearchBar(
                    controller: searchController,
                    backgroundColor: WidgetStatePropertyAll(Color(0xffF0F0F0)),
                    elevation: WidgetStatePropertyAll(0),
                    surfaceTintColor: WidgetStatePropertyAll(Colors.white),
                    side: WidgetStatePropertyAll(
                        BorderSide(style: BorderStyle.none)),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(),
                    ),
                    hintText: 'Search',
                    leading: Icon(Icons.search),
                    onChanged: searchBox,
                    onTap: _whenTapped,
                    // onTapOutside: (event) {
                    //   _whenTappedOutside();
                    // },
                  ),
                ),
                widget.isTapped == true
                    ? Padding(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: SizedBox(
                          height: 300,
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: widget.searchList.length,
                            itemBuilder: (context, index) {
                              final search = widget.searchList[index];
                              return ListTile(
                                leading: Image.asset(
                                  search.imageURL,
                                ),
                                title: Text(search.context),
                                onTap: () {},
                              );
                            },
                          ),
                        ),
                      )
                    : SizedBox(),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: _whenTappedOutside,
              child: CarouselSlider(
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
                  initialPage: 0,
                  onPageChanged: (index, reason) {
                    if (index == 0) {
                      setState(() {
                        widget.isActive = true;
                      });
                    } else {
                      setState(() {
                        widget.isActive = false;
                      });
                    }
                  },
                  autoPlay: true,
                  enlargeCenterPage: true,
                  height: 200,
                ),
              ),
            ),
            GestureDetector(
              onTap: _whenTappedOutside,
              child: Row(
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
                      color: widget.isActive == true
                          ? Color(0xffECB607)
                          : Colors.black,
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
                      color: widget.isActive == false
                          ? Color(0xffECB607)
                          : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: _whenTappedOutside,
              child: Padding(
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
            ),
            GestureDetector(
              onTap: _whenTappedOutside,
              child: SizedBox(
                height: 130,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    //final search = widget.searchList[index];
                    return Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: HomeCard(
                        cardImage: widget.ListImages[index],
                        cardText: widget.ListText[index],
                      ),
                    );
                  },
                  itemCount: widget.ListImages.length,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: _bannerAd == null
                    ? CircularProgressIndicator(
                        color: Color(
                          0xffECB607,
                        ),
                      )
                    : AdWidget(ad: _bannerAd!),
                height: 50,
                //width: 300,
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

  void searchBox(String query) {
    _inSearchBox();
    final suggestions = allItems.where((search) {
      final searchTitle = search.context.toLowerCase();
      final input = query.toLowerCase();
      return searchTitle.contains(input);
    }).toList();
    setState(() {
      widget.searchList = suggestions;
    });
  }
}
