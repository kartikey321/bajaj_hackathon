import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:krishi_sahayak/constants.dart';

import 'OTPScreen.dart';
import 'homeScreen.dart';
import 'signupScreen.dart';

late String phoneno;

final FirebaseAuth _auth = FirebaseAuth.instance;

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  void initState() {
    // TODO: implement initState
    super.initState();
    if (_auth.currentUser != null) {
      Future.delayed(Duration.zero, () {
        Navigator.pushNamedAndRemoveUntil(
            context, HomeScreen.id, (route) => false);
      });
    }
  }

  Future<void> verifyPhoneNumber() async {}
  @override
  Widget build(BuildContext context) {
    var name;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: Color(0xFFF8FFF5),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 0.075 * width),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 50.0,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 0.5 * width),
                              width: 130.0,
                              height: 130.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(
                                  0xFF9DDAAA,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                      height: 40.0,
                                      width: 40.0,
                                      margin: EdgeInsets.only(
                                          left: 95.0, top: 10.0),
                                      child: Image.asset(
                                          'assets/images/bird.png')),
                                  Text(
                                    'Sign In',
                                    style: GoogleFonts.poppins(
                                      color: Color(0xFF70AF85),
                                      fontStyle: FontStyle.normal,
                                      textStyle: TextStyle(
                                        fontSize: 22.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 55.0,
                        ),
                        // Text(
                        //   'Name:',
                        //   style: GoogleFonts.poppins(
                        //     fontStyle: FontStyle.normal,
                        //     textStyle: TextStyle(fontSize: 25.0),
                        //   ),
                        // ),
                        // SizedBox(
                        //   width: .8 * width,
                        //   child: TextField(
                        //     keyboardType: TextInputType.name,
                        //     textAlign: TextAlign.center,
                        //     onChanged: (value) {
                        //       name = value;
                        //       //print(name);
                        //     },
                        //     decoration: kTextFieldDecoration.copyWith(
                        //       hintText: 'Enter your name',
                        //     ),
                        //   ),
                        // ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 0.5 * width),
                          child: Text(
                            'Phone.No:',
                            style: GoogleFonts.poppins(
                              fontStyle: FontStyle.normal,
                              textStyle: TextStyle(fontSize: 25.0),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25.0,
                        ),
                        SizedBox(
                          width: 0.85 * width,
                          child: Row(
                            children: [
                              Flexible(
                                  flex: 1,
                                  child: Container(
                                    child: CountryCodePicker(
                                      initialSelection: 'IN',
                                      enabled: false,
                                      alignLeft: true,
                                    ),
                                  )),
                              Flexible(
                                flex: 2,
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  onChanged: (value) {
                                    phoneno = value;

                                    //print(phoneno);
                                  },
                                  decoration: kTextFieldDecoration.copyWith(
                                    hintText: 'Enter your phone no',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 50.0,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Color(0xFF7FCD91),
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0),
                              ),
                              padding:
                                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0)),
                          onPressed: () {
                            if (phoneno != null) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => OtpScreen(
                                            phoneno: phoneno,
                                          )));
                              print('verify pressed');
                            }
                          },
                          child: Text(
                            'Verify',
                            style: GoogleFonts.poppins(
                              fontStyle: FontStyle.normal,
                              textStyle: TextStyle(fontSize: 22.0),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 35,
                        ),
                        Text('Don\'t have an account?',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                fontStyle: FontStyle.normal,
                                textStyle: TextStyle(
                                  fontSize: 15.0,
                                ))),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, SignupScreen.id);
                          },
                          child: Text('Create one here',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                  color: Color(0xFF70AF85),
                                  fontStyle: FontStyle.normal,
                                  textStyle: TextStyle(
                                    fontSize: 15.0,
                                  ))),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  Row(
                    children: [
                      Container(
                        alignment: Alignment(-1.9, -1.0),
                        child: Image.asset('assets/images/cropimg(1).png'),
                      ),
                      SizedBox(
                        width: 0.45 * width,
                      ),
                      Container(
                        child: Image.asset('assets/images/scarecrow.png'),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
