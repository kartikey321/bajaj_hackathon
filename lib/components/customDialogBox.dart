import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:krishi_sahayak/screens/alertScreen.dart';

class CustomDialogBox extends StatefulWidget {
  const CustomDialogBox({Key? key}) : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;
  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 750));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);
    controller.addListener(() {
      setState(() {});
    });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
      child: ScaleTransition(
        scale: scaleAnimation,
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Stack(
            overflow: Overflow.visible,
            alignment: Alignment.topCenter,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.red, width: 4),
                ),
                height: 350,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 70, 10, 10),
                  child: Column(
                    children: [
                      Text(
                        'Warning',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Pests Detected',
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(height: 7),
                      Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.red, width: 3),
                          ),
                          child: Column(
                            children: [
                              Text(
                                'Possible Pests',
                                style: GoogleFonts.poppins(
                                  fontStyle: FontStyle.normal,
                                  textStyle: TextStyle(
                                    fontSize: 20.0,
                                  ),
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Termites',
                                style: GoogleFonts.poppins(
                                  fontStyle: FontStyle.normal,
                                  textStyle: TextStyle(
                                    fontSize: 18.0,
                                  ),
                                ),
                              ),
                              Text(
                                'Jassids',
                                style: GoogleFonts.poppins(
                                  fontStyle: FontStyle.normal,
                                  textStyle: TextStyle(
                                    fontSize: 18.0,
                                  ),
                                ),
                              ),
                            ],
                          )),
                      SizedBox(height: 20),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Go to',
                              style: GoogleFonts.poppins(
                                fontStyle: FontStyle.normal,
                                textStyle: TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                            SizedBox(width: 5),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AlertScreen()));
                              },
                              child: Container(
                                  child: Row(
                                children: [
                                  Text(
                                    'Alerts',
                                    style: GoogleFonts.poppins(
                                      fontStyle: FontStyle.normal,
                                      textStyle: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  SvgPicture.asset('assets/svgs/arrow.svg')
                                  // Image.asset(
                                  //   'assets/images/arrow.png',
                                  //   height: 35,
                                  // ),
                                ],
                              )),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                top: -60,
                child: CircleAvatar(
                  backgroundColor: Colors.redAccent,
                  radius: 60,
                  child: Icon(
                    Icons.pest_control_outlined,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
