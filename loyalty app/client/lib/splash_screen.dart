import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loyalty_app/login_screen.dart';
import 'package:loyalty_app/services/splash_services.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splash_screen';
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    SplashServices().checkAuthentication(context);
    // Timer(const Duration(seconds: 5), () {
    //   // Navigate to the welcome screen
    //   Navigator.of(context).pushReplacement(
    //     MaterialPageRoute(
    //       builder: (context) => LoginScreen(),
    //     ),
    //   );
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // appBar: AppBar(),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Positioned(
                top: 100,
                left: 100,
                right: 100,
                bottom: 0,
                child: SvgPicture.asset("assets/ellipse.svg")),
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/welcome.svg",
                  ),
                  Positioned(
                      top: 100,
                      child: Image.asset('assets/welcome_page_image.png')),
                ],
              ),
            ),
            // Align(
            //     alignment: Alignment.bottomRight,
            //     heightFactor: 1,
            //     child: Positioned(
            //         top: 0, child: SvgPicture.asset("assets/ellipse.svg"))),
          ],
        ),
      ),
    );
  }
}
