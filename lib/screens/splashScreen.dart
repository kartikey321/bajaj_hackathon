import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:krishi_sahayak/screens/loginScreen.dart';

class SplashScreen extends StatefulWidget {
  static String id = 'splash_screen';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
      Duration(seconds: 3),
      () => Navigator.pushNamed(context, LoginScreen.id),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8FFF5),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/splash_screen.png'),
            SizedBox(
              height: 300,
            ),
            CircularProgressIndicator(
              color: Color(0xFF7FCD91),
            )
          ],
        ),
      ),
    );
  }
}
