import 'dart:async';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:jackpot_arena/Firebase/firebaseFunctions.dart';
import 'package:jackpot_arena/Firebase/userDetails.dart';
import 'package:jackpot_arena/Provider/counterProvider.dart';
import 'package:jackpot_arena/Screens/gamesScreen.dart';
import 'package:jackpot_arena/Screens/notificationScreen.dart';
import 'package:jackpot_arena/Screens/withdrawHistoryScreen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
  UserDetails user = UserDetails();
  int notificationCount = 100;
  int transactionCount = 100;
  int temp = 0;
}

class _HomeScreenState extends State<HomeScreen> {
  late StreamSubscription subscription;
  var isDeviceConnected = false;
  bool isAlertSet = false;
  late double gameCoin, realMoney;
  double? aggregate = 0.001;

  @override
  void initState() {
    super.initState();
    getData();
    getNotificationCount();
    getTransactionCount();
    getConnectivity();
  }

  getNotificationCount() async {
    int count = 0;
    try {
      CollectionReference reference =
          FirebaseFirestore.instance.collection('Notifications');
      QuerySnapshot snapshot = await reference.get();
      print('calling');
      snapshot.docs.forEach((doc) {
        if (FirebaseAuth.instance.currentUser!.email == doc['UserID'] &&
            doc['Status'] == 'unseen') {
          if (count != widget.notificationCount) {
            count++;
            print('getting...');
          }
        }
      });
      setState(() {
        widget.notificationCount = count;
      });
    } catch (e) {
      print(e);
    }
    print(widget.notificationCount);
    print(count);
  }

  getTransactionCount() async {
    int tcount = 0;
    try {
      CollectionReference reference =
          FirebaseFirestore.instance.collection('Transactions');
      QuerySnapshot snapshot = await reference.get();
      print('calling');
      snapshot.docs.forEach((doc) {
        if (FirebaseAuth.instance.currentUser!.email == doc['UserID'] &&
            doc['Status'] == 'unseen') {
          if (tcount != widget.transactionCount) {
            tcount++;
            print('getting...');
          }
        }
      });
      setState(() {
        widget.transactionCount = tcount;
      });
      return true;
    } catch (e) {
      print(e);
    }
    print(widget.transactionCount);
    print(tcount);
  }

  getData() async {
    //getNotificationCount();
    try {
      CollectionReference getDataReference = FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .collection('Earning');
      QuerySnapshot snapshot = await getDataReference.get();
      snapshot.docs.forEach((doc) {
        setState(() {
          widget.user.gameCoins = doc['Game Coins'];
          widget.user.realMoney = doc['Real Money'];
        });
      });

      print(widget.user.gameCoins);
      return true;
    } on FirebaseException catch (e) {
      print(e.message.toString());
      return false;
    }
  }

  getConnectivity() {
    //_getData();
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

  int _selectedIndex = 0;

  List<Widget> pages = [
    GamesScreen(),
    Notificationscreen(),
    Withdrawhistoryscreen(),
    Container(
      color: Colors.purple,
    ),
  ];
  List<IconData> barIcons = [
    Icons.gamepad_outlined,
    Icons.notifications_outlined,
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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 5),
                  child: Column(
                    children: [
                      Flexible(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
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
                                  widget.user.gameCoins != null
                                      ? widget.user.gameCoins.toString()
                                      : '0',
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
                                Radius.circular(5),
                              ),
                              color: const Color(0xff409023),
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 2),
                                  child: Image.asset(
                                    'assets/image 10.png',
                                    height: 25,
                                  ),
                                ),
                                const SizedBox(
                                  width: 13,
                                ),
                                Text(
                                  widget.user.realMoney != null
                                      ? widget.user.realMoney.toString()
                                      : '0',
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                  width: 13,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    right: 6,
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
                SizedBox(
                  width: 3,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5, right: 10),
                  child: GestureDetector(
                    onTap: () => Firebasefunctions().logout(context),
                    child: CircleAvatar(
                      foregroundImage: AssetImage(
                        'assets/Plink.png',
                      ),
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
        child: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Notifications')
                .doc()
                .snapshots(),
            builder: (context, snapshot) {
              widget.notificationCount != 0 && widget.notificationCount != 100
                  ? getNotificationCount()
                  : null;
              return pages[_selectedIndex];
            }),
      ),
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: barIcons.length,
        tabBuilder: (index, isActive) {
          return Stack(
            textDirection: TextDirection.rtl,
            alignment: Alignment.center,
            fit: StackFit.loose,
            children: [
              Icon(
                barIcons[index],
                size: 28,
                color: isActive ? Color(0xffFF6007) : Colors.grey,
              ),
              index == 1 || index == 2
                  ? Padding(
                      padding:
                          const EdgeInsets.only(left: 30, bottom: 25, right: 5),
                      child: Container(
                        child: index == 1
                            ? Container(
                                child: widget.notificationCount != 0 &&
                                        widget.notificationCount != 100
                                    ? Container(
                                        height: 15,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.red,
                                        ),
                                        alignment: Alignment.topCenter,
                                        child: Text(
                                          widget.notificationCount.toString(),
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontSize: 10,
                                          ),
                                        ),
                                      )
                                    : SizedBox(),
                              )
                            : Container(
                                child: index == 2
                                    ? Container(
                                        child: widget.transactionCount != 0 &&
                                                widget.transactionCount != 100
                                            ? Container(
                                                height: 15,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.red,
                                                ),
                                                alignment: Alignment.topCenter,
                                                child: Text(
                                                  widget.transactionCount
                                                      .toString(),
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.poppins(
                                                    color: Colors.white,
                                                    fontSize: 10,
                                                  ),
                                                ),
                                              )
                                            : SizedBox(),
                                      )
                                    : SizedBox(),
                              ),
                      ),
                    )
                  : SizedBox(),
            ],
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
          if (index == 2) {
            //getNotificationCount();
            widget.transactionCount = 0;
          } else if (index == 0) {
            //getNotificationCount();
          }
        }),
      ),
    );
  }
}
