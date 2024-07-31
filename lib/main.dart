import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jackpot_arena/ForgotPassword/verificationScreen.dart';
import 'package:jackpot_arena/Screens/gamesScreen.dart';
import 'package:jackpot_arena/Screens/homeScreen.dart';
import 'package:jackpot_arena/Startup/splashScreen.dart';
import 'package:jackpot_arena/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Jackpot Arena',
      theme: ThemeData(
        primarySwatch: Colors.green,
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.light,
      home: SplashScreen(),
    );
  }
}
