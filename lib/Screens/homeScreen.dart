import 'dart:async';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:jackpot_arena/Firebase/firebaseFunctions.dart';
import 'package:jackpot_arena/Screens/gamesScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late StreamSubscription subscription;
  var isDeviceConnected = false;
  bool isAlertSet = false;

  @override
  void initState() {
    super.initState();
    getConnectivity();
  }

  getConnectivity() {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) async {
      isDeviceConnected = await InternetConnectionChecker().hasConnection;
      if (!isDeviceConnected && isAlertSet == false) {
        showDialogBox();
        setState(() {
          isAlertSet = true;
        });
      }
    });
  }

  showDialogBox() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          insetPadding: EdgeInsets.all(0),
          scrollable: true,
          alignment: Alignment.bottomCenter,
          backgroundColor: Colors.red,
          shape: BeveledRectangleBorder(),
          iconPadding: EdgeInsets.all(0),
          icon: Icon(
            Icons.wifi_off,
            color: Colors.white,
          ),
          contentPadding: EdgeInsets.only(left: 5),
          content: Text(
            'Internet Connection Lost',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              color: Colors.white,
            ),
          ),
          buttonPadding: EdgeInsets.all(0),
          actionsPadding: EdgeInsets.all(0),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.pop(context, 'Cancel');
                setState(() {
                  isAlertSet = false;
                });
                isDeviceConnected =
                    await InternetConnectionChecker().hasConnection;
                if (!isDeviceConnected) {
                  showDialogBox();
                  setState(() {
                    isAlertSet = true;
                  });
                }
              },
              child: Text(
                'Continue',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

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
    Icons.gamepad_outlined,
    Icons.notifications_active_outlined,
    Icons.file_open_outlined,
    Icons.person_3_outlined,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Image.asset(
          "assets/JACKPOTARENA.png",
          height: 15,
        ),
        toolbarHeight: 70,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
                        child: GestureDetector(
                          onTap: () => null,
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
                                  padding: const EdgeInsets.only(left: 3),
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
                      //   filterQuality: FilterQuality.high,
                      // ),
                      //radius: 30,
                      maxRadius: 30,
                      minRadius: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: DoubleBackToCloseApp(
          snackBar: SnackBar(
            content: Text('Back again to leave app.'),
          ),
          child: pages[_selectedIndex]),
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: barIcons.length,
        tabBuilder: (index, isActive) {
          return Icon(
            barIcons[index],
            size: 28,
            color: isActive ? Color(0xffFF6007) : Colors.grey,
          );
        },
        splashRadius: 30,
        splashColor: Color(0xffFFB6C1),
        //splashSpeedInMilliseconds: 800,
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
