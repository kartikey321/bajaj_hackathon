import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:krishi_sahayak/components/loading.dart';
import 'package:pinput/pin_put/pin_put.dart';

import 'homeScreen.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;

class OtpScreen extends StatefulWidget {
  static String id = 'Otp_screen';
  OtpScreen({@required this.phoneno, this.name});
  final phoneno;
  final name;

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  late String _verificationCode;
  final _pinPutController = TextEditingController();
  final _pinPutFocusNode = FocusNode();
  var name;
  bool showSpinner = false;
  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: const Color.fromRGBO(43, 46, 66, 1),
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(
      color: const Color.fromRGBO(126, 203, 224, 1),
    ),
  );

  _verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91${widget.phoneno}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential).then((value) async {
            if (value.user != null) {
              print('user logged in!');
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String verificationID, int? resendToken) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
            _scaffoldkey.currentState!
                .showSnackBar(SnackBar(content: Text('invalid OTP')));
          });
        },
        timeout: Duration(seconds: 60));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    name = widget.name;
    print(name);
    _verifyPhone();
  }

  @override
  Widget build(BuildContext context) {
    return showSpinner
        ? Loading()
        : Scaffold(
            backgroundColor: Color(0xFFF8FFF5),
            body: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 40.0),
                  child: Center(
                    child: Text(
                      'Verify +91 ${widget.phoneno}',
                      style: GoogleFonts.poppins(
                        color: Color(0xFF70AF85),
                        fontStyle: FontStyle.normal,
                        textStyle: TextStyle(
                          fontSize: 22.0,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: PinPut(
                    fieldsCount: 6,
                    withCursor: true,
                    textStyle:
                        const TextStyle(fontSize: 25.0, color: Colors.white),
                    eachFieldWidth: 40.0,
                    eachFieldHeight: 55.0,
                    onSubmit: (pin) async {
                      setState(() {
                        showSpinner = true;
                      });
                      try {
                        print(pin);
                        await FirebaseAuth.instance
                            .signInWithCredential(PhoneAuthProvider.credential(
                                verificationId: _verificationCode,
                                smsCode: pin))
                            .then((value) async {
                          print('value:  $value');
                          if (value.user != null) {
                            if (name != null) {
                              print('before otp ${name}');

                              await _firestore
                                  .collection('users')
                                  .doc(_auth.currentUser!.uid)
                                  .set({
                                'name': name,
                                'phoneNo': '+91${widget.phoneno}',
                              }, SetOptions(merge: true));
                            }
                            Navigator.pushNamedAndRemoveUntil(context,
                                HomeScreen.id, (Route<dynamic> route) => false);
                            setState(() {
                              showSpinner = false;
                            });
                          }
                        });
                      } catch (e) {
                        FocusScope.of(context).unfocus();
                      }
                    },
                    focusNode: _pinPutFocusNode,
                    controller: _pinPutController,
                    submittedFieldDecoration: pinPutDecoration,
                    selectedFieldDecoration: pinPutDecoration,
                    followingFieldDecoration: pinPutDecoration,
                    pinAnimationType: PinAnimationType.fade,
                  ),
                ),
              ],
            ),
          );
  }
}
