import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:krishi_sahayak/constants.dart';

import 'OTPScreen.dart';
import 'loginScreen.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class SignupScreen extends StatefulWidget {
  static String id = 'signup_screen';

  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

late String name1;
late String phoneno;

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _nameController = TextEditingController();
    TextEditingController _phoneNoController = TextEditingController();

    double width = MediaQuery.of(context).size.width;

    // void signup(String name, String phoneno) async{
    //   try{
    //
    //   }catch{
    //
    //   }
    // }

    return Scaffold(
        backgroundColor: Color(0xFFF8FFF5),
        body: SingleChildScrollView(
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
                                    margin:
                                        EdgeInsets.only(left: 95.0, top: 10.0),
                                    child:
                                        Image.asset('assets/images/bird.png')),
                                Text(
                                  'Sign Up',
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
                      Text(
                        'Name:',
                        style: GoogleFonts.poppins(
                          fontStyle: FontStyle.normal,
                          textStyle: TextStyle(fontSize: 25.0),
                        ),
                      ),
                      SizedBox(
                        width: .8 * width,
                        child: TextField(
                          keyboardType: TextInputType.name,
                          textAlign: TextAlign.center,
                          // controller: _nameController,
                          onChanged: (value) {
                            name1 = value;
                            print(name1);
                          },
                          decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Enter your name',
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Phone.No:',
                        style: GoogleFonts.poppins(
                          fontStyle: FontStyle.normal,
                          textStyle: TextStyle(fontSize: 25.0),
                        ),
                      ),
                      SizedBox(
                        width: .8 * width,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          //controller: _phoneNoController,
                          onChanged: (value) {
                            phoneno = value;

                            print(phoneno);
                          },
                          decoration: kTextFieldDecoration.copyWith(
                            prefixText: '+91',
                            hintText: 'Enter your phone no',
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 80.0,
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
                          print('before passed $name1');
                          print('before passed $phoneno');

                          if (phoneno != null && name1 != null) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OtpScreen(
                                          // sinup(_nameController.text,_phoneNoController.text);
                                          phoneno: phoneno,
                                          name: name1,
                                        )));
                            print('verify pressed');
                          } else {
                            return null;
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
                      Text('Already have an account?',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              fontStyle: FontStyle.normal,
                              textStyle: TextStyle(
                                fontSize: 15.0,
                              ))),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, LoginScreen.id);
                        },
                        child: Text('Sign in here',
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
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Container(
                      alignment: Alignment(-1.9, -1.0),
                      child: Image.asset('assets/images/wheat(1).png'),
                    ),
                    SizedBox(
                      width: 0.47 * width,
                    ),
                    Container(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 85.0,
                          ),
                          Image.asset('assets/images/bagwheat.png'),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
