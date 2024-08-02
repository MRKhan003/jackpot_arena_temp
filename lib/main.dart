import 'package:email_otp/email_otp.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jackpot_arena/AccountAuth/loginUser.dart';
import 'package:jackpot_arena/Firebase/firebaseFunctions.dart';
import 'package:jackpot_arena/ForgotPassword/emailScreen.dart';
import 'package:jackpot_arena/NetworkCheck/dependencyInjection.dart';
import 'package:jackpot_arena/Screens/homeScreen.dart';
import 'package:jackpot_arena/Startup/splash.dart';
import 'package:jackpot_arena/Startup/splashScreen.dart';
import 'package:jackpot_arena/firebase_options.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
  Dependencyinjection.init();
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Firebasefunctions(),
        ),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Jackpot Arena',
        theme: ThemeData(
          primarySwatch: Colors.green,
          useMaterial3: true,
        ),
        darkTheme: ThemeData.dark(),
        themeMode: ThemeMode.light,
        home: SplashScreen(),
      ),
    );
  }
}
