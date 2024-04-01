import 'package:flutter/material.dart';
import 'package:loyalty_app/card_screen.dart';
import 'package:loyalty_app/history_screen.dart';
import 'package:loyalty_app/home_screen.dart';
import 'package:loyalty_app/login_screen.dart';
import 'package:loyalty_app/reward_screen.dart';
import 'package:loyalty_app/splash_screen.dart';

import 'sign_up.dart';

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
      // home: HomeScreen(),
      home: SplashScreen(),
    );
  }
}
