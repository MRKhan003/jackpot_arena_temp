import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jackpot_arena/Providers/bankInfoProvider.dart';
import 'package:jackpot_arena/Startup/splashScreen.dart';
import 'package:jackpot_arena/firebase_options.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => Bankinfoprovider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
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
