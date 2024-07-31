import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
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
    Container(),
    Container(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          Expanded(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: SvgPicture.asset(
                    'assets/JACKPOTARENA.svg',
                    height: 20,
                  ),
                ),
                SizedBox(
                  width: 25,
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Container(
                        color: Color(0xffEFCC4E),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Image.asset(
                                'assets/Image 9.png',
                                height: 15,
                              ),
                            ),
                            SizedBox(
                              width: 18,
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
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      color: Color(0xff409023),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Image.asset(
                              'assets/Image 10.png',
                              height: 15,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            '5000',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: Image.asset(
                              'assets/Icon.png',
                              height: 15,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.games,
            ),
            label: 'Games',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.notifications_rounded,
            ),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.file_open,
            ),
            label: 'File open',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(
          //     Icons.person_4,
          //   ),
          //   label: 'Profile',
          // ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xffF8B31A),
        onTap: _onItemTapped,
      ),
    );
  }
}
