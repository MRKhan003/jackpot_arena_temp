import 'package:flutter/material.dart';
import 'package:jackpot_arena/Startup/Onboarding/screen1.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateScreen();
  }

  _navigateScreen() async {
    await Future.delayed(
      const Duration(
        seconds: 5,
      ),
    );
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Screen1(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            Text(
              "JACKPOTARENA",
            ),
            Image.asset(
              "assets/airplane.png",
              filterQuality: FilterQuality.high,
            ),
          ],
        ),
      ),
    );
  }
}
