import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:krishi_sahayak/screens/homeScreen.dart';
import 'package:krishi_sahayak/screens/loginScreen.dart';
import 'package:krishi_sahayak/screens/signupScreen.dart';
import 'package:onboarding_screen/onboarding_screen.dart';

class OnboardingScreen extends StatefulWidget {
  static String id = 'onboarding_screen';

  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();

  final List<_SliderModel> mySlides = [
    _SliderModel(
      imageAssetPath: Image.asset(
        'assets/images/splash_screen.png',
        scale: 1,
      ),
      title: '',
      desc: '',
    ),
    _SliderModel(
      imageAssetPath: Image.asset(
        'assets/images/2.png',
        scale: 1,
      ),
      title: 'Easily Monitor Farm Parameters',
      desc: 'Monitor farm parameters such as humidity, soil and moisture',
      descStyle: GoogleFonts.poppins(
        fontStyle: FontStyle.normal,
        textStyle: TextStyle(
          fontSize: 16.0,
        ),
      ),
      titleStyle: GoogleFonts.poppins(
        fontStyle: FontStyle.normal,
        textStyle: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
      ),
    ),
    _SliderModel(
      imageAssetPath: Image.asset(
        'assets/images/3.png',
        scale: 1,
      ),
      title: 'Real Time Notification',
      desc: 'Get real time voice notification right on your phone',
      descStyle: GoogleFonts.poppins(
        fontStyle: FontStyle.normal,
        textStyle: TextStyle(
          fontSize: 16.0,
        ),
      ),
      titleStyle: GoogleFonts.poppins(
        fontStyle: FontStyle.normal,
        textStyle: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return OnBoardingScreen(
      label: const Text(
        'Get Started',
        key: Key('get_started'),
      ),

      /// This function works when you will complete `OnBoarding`
      function: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => SignupScreen(),
          ),
        );
      },

      /// This [mySlides] must not be more than 5.
      mySlides: mySlides,
      controller: _controller,
      slideIndex: 0,

      indicators: Indicators.cool,
      skipPosition: SkipPosition.bottomRight,
      skipDecoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(20.0),
      ),
      skipStyle: TextStyle(color: Colors.white),

      pageIndicatorColorList: [
        Colors.yellow,
        Colors.green,
        Colors.red,
        Colors.yellow,
        Colors.blue
      ],
    );
  }
}

class _SliderModel {
  const _SliderModel({
    this.imageAssetPath,
    this.title = "title",
    this.desc = "title",
    this.miniDescFontSize = 12.0,
    this.minTitleFontSize = 15.0,
    this.descStyle,
    this.titleStyle,
  });

  final Image? imageAssetPath;
  final String title;
  final TextStyle? titleStyle;
  final double minTitleFontSize;
  final String desc;
  final TextStyle? descStyle;
  final double miniDescFontSize;
}
