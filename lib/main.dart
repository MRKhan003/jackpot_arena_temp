import 'package:flutter/material.dart';
import 'package:jackpot_arena/AccountAuth/accountCreation.dart';
import 'package:jackpot_arena/AccountAuth/loginUser.dart';
import 'package:jackpot_arena/ForgotPassword/newPassword.dart';
import 'package:jackpot_arena/ForgotPassword/verificationScreen.dart';
import 'package:jackpot_arena/Screens/homeScreen.dart';
import 'package:jackpot_arena/Startup/Onboarding/screen1.dart';
import 'package:jackpot_arena/Startup/Onboarding/screen2.dart';
import 'package:jackpot_arena/Startup/Onboarding/screen3.dart';
import 'package:jackpot_arena/Startup/splashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}
