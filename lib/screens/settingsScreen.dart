import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Language { English, Hindi }

class SettingsScreen extends StatefulWidget {
  static String id = 'settings_screen';

  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

bool isNotifOn = true;
bool lang = false;

class _SettingsScreenState extends State<SettingsScreen> {
  Language selectedLanguage = Language.English;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF7FCD91),
        leading: Icon(FontAwesomeIcons.arrowLeft),
        title: Text(
          'Settings',
          style: GoogleFonts.poppins(
            fontStyle: FontStyle.normal,
            textStyle: TextStyle(
              fontSize: 22.0,
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top: 80.0),
              width: 0.92 * width,
              padding: EdgeInsets.fromLTRB(12, 30, 12, 30),
              decoration: BoxDecoration(
                color: Color(0x288EE2A2),
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(
                  color: Color(0xFF77B255),
                ),
              ),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/speak.png',
                    height: 50,
                  ),
                  Container(
                    margin: EdgeInsets.all(3.0),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 120.0),
                          child: Text(
                            'Voice Control',
                            textAlign: TextAlign.left,
                            style: GoogleFonts.poppins(
                              fontStyle: FontStyle.normal,
                              textStyle: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 17.5,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          'Press toggle switch to manage notification',
                          style: GoogleFonts.poppins(
                            fontStyle: FontStyle.normal,
                            textStyle: TextStyle(
                              fontSize: 11.4,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 60.0,
                    child: Switch(
                      value: isNotifOn,
                      onChanged: (value) {
                        setState(() {
                          isNotifOn = value;
                          setChangeNotification(value);
                        });
                      },
                      activeTrackColor: Colors.lightGreenAccent,
                      activeColor: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 35.0,
            ),
            Container(
              width: 0.92 * width,
              padding: EdgeInsets.fromLTRB(12, 30, 12, 30),
              decoration: BoxDecoration(
                color: Color(0x288EE2A2),
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(
                  color: Color(0xFF77B255),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/language.png',
                        height: 55.0,
                      ),
                      Column(
                        children: [
                          Container(
                            child: Text(
                              'Switch Language',
                              textAlign: TextAlign.left,
                              style: GoogleFonts.poppins(
                                fontStyle: FontStyle.normal,
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17.5,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            'Press toggle switch to manage notification',
                            style: GoogleFonts.poppins(
                              fontStyle: FontStyle.normal,
                              textStyle: TextStyle(
                                fontSize: 11.4,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 1.0,
                    color: Color(0xFF5C913B),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 0.15 * width, top: 20.0),
                    child: Center(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();

                              prefs.setString('lang', 'en-IN');
                              setState(() {
                                selectedLanguage = Language.English;
                              });
                            },
                            child: Container(
                              child: SvgPicture.asset(
                                selectedLanguage == Language.English
                                    ? 'assets/svgs/english_select.svg'
                                    : 'assets/svgs/english.svg',
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 30.0,
                          ),
                          GestureDetector(
                            onTap: () async {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setString('lang', 'hi-IN');
                              setState(() {
                                selectedLanguage = Language.Hindi;
                              });
                            },
                            child: Container(
                              child: SvgPicture.asset(
                                selectedLanguage == Language.Hindi
                                    ? 'assets/svgs/hindi_select.svg'
                                    : 'assets/svgs/hindi.svg',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 38.0,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.red),
              ),
              child: Text(
                'Log Out',
                style: GoogleFonts.poppins(
                  fontStyle: FontStyle.normal,
                  textStyle: TextStyle(
                    fontSize: 18.0,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 70.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Image.asset(
                    'assets/images/corn.png',
                    fit: BoxFit.contain,
                    height: 16,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Krishi sahayak.Inc',
                    style: GoogleFonts.poppins(
                      fontStyle: FontStyle.normal,
                      textStyle: TextStyle(
                        fontSize: 10.0,
                      ),
                    ),
                  ),
                ),
                Container(
                  child: Image.asset(
                    'assets/images/corn.png',
                    fit: BoxFit.contain,
                    height: 16,
                  ),
                ),
              ],
            ),
            Container(
              width: width,
              child: Image.asset(
                'assets/images/grass.png',
                width: width,
              ),
            )
          ],

          // Text(isNotifOn.toString()),
          // Switch(
          //   value: isNotifOn,
          //   onChanged: (value) {
          //     setState(() {
          //       isNotifOn = value;
          //       setChangeNotification(value);
          //     });
          //   },
          //   activeTrackColor: Colors.lightGreenAccent,
          //   activeColor: Colors.green,
          // ),
          // Switch(
          //   value: lang,
          //   onChanged: (value) {
          //     setState(() {
          //       lang = value;
          //       setChangeLang(value);
          //     });
          //   },
          //   activeTrackColor: Colors.lightGreenAccent,
          //   activeColor: Colors.green,
          // ),
        ),
      ),
    );
  }

  setChangeNotification(bool value) {
    changeNotificationState(value);
  }

  setChangeLang(bool value) {
    changeLanguage(value);
  }

  changeNotificationState(bool isNotifOn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('notifState', isNotifOn);
    print(isNotifOn);
  }

  changeLanguage(bool lang) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    lang ? prefs.setString('lang', 'hi-IN') : prefs.setString('lang', 'en-IN');
    print(prefs.getString('lang'));
  }
}
