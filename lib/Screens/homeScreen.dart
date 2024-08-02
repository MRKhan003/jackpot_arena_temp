import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jackpot_arena/Firebase/firebaseFunctions.dart';
import 'package:jackpot_arena/Screens/gamesScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  int _selectedIndex = 0;

  List<Widget> pages = [
    GamesScreen(),
    Container(
      color: Colors.green,
    ),
    Container(
      color: Colors.blue,
    ),
    Container(
      color: Colors.purple,
    ),
  ];
  List<IconData> barIcons = [
    Icons.games,
    Icons.notifications,
    Icons.file_open,
    Icons.person,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 4),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Image.asset(
                    "assets/JACKPOTARENA.png",
                    height: 15,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 5),
                child: Column(
                  children: [
                    Flexible(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          color: const Color(0xffEFCC4E),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Image.asset(
                                'assets/image 9.png',
                                height: 25,
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: Text(
                                '100,000',
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Flexible(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          color: const Color(0xff409023),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Image.asset(
                                'assets/image 10.png',
                                height: 25,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              '5000',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                right: 5,
                                top: 2,
                                bottom: 2,
                              ),
                              child: Image.asset(
                                'assets/Icon1.png',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5, right: 10),
                child: GestureDetector(
                  onTap: () => Firebasefunctions().logout(context),
                  child: CircleAvatar(
                    foregroundImage: AssetImage(
                      'assets/Plink.png',
                    ),
                    // child: Image.asset(
                    //   'assets/Plink.png',
                    // ),
                    radius: 30,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: barIcons.length,
        tabBuilder: (index, isActive) {
          return Icon(
            barIcons[index],
            size: 28,
            color: isActive ? Color(0xffFF6007) : Colors.grey,
          );
        },
        splashRadius: 10,
        splashColor: Color(0xffFFB6C1),
        splashSpeedInMilliseconds: 800,
        gapLocation: GapLocation.none,
        notchSmoothness: NotchSmoothness.verySmoothEdge,
        leftCornerRadius: 32,
        rightCornerRadius: 32,
        activeIndex: _selectedIndex,
        onTap: (index) => setState(() {
          _selectedIndex = index;
        }),
      ),
    );
  }
}
