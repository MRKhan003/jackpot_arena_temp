import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class NetworkDetect extends StatefulWidget {
  const NetworkDetect({super.key});

  @override
  State<NetworkDetect> createState() => _NetworkDetectState();
}

class _NetworkDetectState extends State<NetworkDetect> {
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
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                'Internet Connection Lost',
              ),
              content: Text(
                'Please Check your Internet Connection',
              ),
              actions: [
                TextButton(
                  onPressed: () {},
                  child: Text('Ok'),
                ),
              ],
            );
          },
        );
        setState(() {
          isAlertSet = true;
        });
      }
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return getConnectivity();
  }
}
