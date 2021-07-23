import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:krishi_sahayak/components/drawer.dart';
import 'package:krishi_sahayak/services/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:krishi_sahayak/components/customDialogBox.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:krishi_sahayak/globalStates.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:translator/translator.dart';

import '../main.dart';
import 'loginScreen.dart';
import 'pestControlScreen.dart';

class HomeScreen extends StatefulWidget {
  static String id = 'home_screen';
  static AudioCache player = AudioCache();

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalStates globalStates = GlobalStates();
  late FirebaseMessaging messaging;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String uid;
  late Position position;

  translator() async {
    final translator = GoogleTranslator();

    Translation translation = await translator.translate('hello', to: 'hi');
    print(translation);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    translator();

    messaging = FirebaseMessaging.instance;
    messaging.getToken().then((fcm_token) {
      print(fcm_token);
      getLocation(fcm_token);
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var n = prefs.getBool('notifState');
      var lang = prefs.getString('lang');
      if (n == true) {
        if (lang == 'hi-IN') {
          final translator = GoogleTranslator();
          var body1 = message.notification!.body;
          Translation translation =
              await translator.translate(body1!.toString(), to: 'hi');
          print(translation.toString().runtimeType);
          Timer(Duration(seconds: 2), () {
            speak(body: translation.toString());
          });
        } else if (lang == 'en-IN') {
          Timer(Duration(seconds: 2), () {
            speak(body: message.notification!.body);
          });
        }
      }
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher',
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title.toString()),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body.toString())],
                  ),
                ),
              );
            });
      }
    });
  }

  Future<void> getLocation(fcm_token) async {
    Location location = Location();
    await location.getCurrentLocation();
    var latitude = location.latitude;
    var longitude = location.longitude;

    uid = FirebaseAuth.instance.currentUser!.uid;
    _firestore.collection('users').doc(uid).set(
        {'latitude': latitude, 'longitude': longitude, 'fcm_token': fcm_token},
        SetOptions(merge: true));
  }

  Future<void> signout() async {
    await _auth.signOut();
    Navigator.pushNamedAndRemoveUntil(
        context, LoginScreen.id, (route) => false);
  }

  playLocal() {
    final player = AudioCache();

    // call this method when desired
    player.play('note4.wav');
  }

  Future speak({body}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? lang = prefs.getString('lang');
    await flutterTts.setLanguage(lang!);

    await flutterTts.speak(body);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      drawer: Drawer1,
      appBar: AppBar(
        backgroundColor: Color(0xFF7FCD91),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(left: 30.0),
              child: Image.asset(
                'assets/images/corn.png',
                fit: BoxFit.contain,
                height: 32,
              ),
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'My Farm',
                style: GoogleFonts.poppins(
                  fontStyle: FontStyle.normal,
                  textStyle: TextStyle(
                    fontSize: 22.0,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 55.0),
              child: Image.asset(
                'assets/images/corn.png',
                fit: BoxFit.contain,
                height: 32,
              ),
            ),
            SizedBox(
              width: 25,
            ),
            GestureDetector(
              onTap: () {
                // playLocal();
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CustomDialogBox();
                    });
              },
              child: Container(
                child: Image.asset(
                  'assets/images/warning.png',
                  fit: BoxFit.contain,
                  height: 32,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 0.4 * width,
              ),
              // Text('userId ${uid}'),
              // ElevatedButton(
              //     onPressed: () {
              //       signout();
              //     },
              //     child: Text('logout'))
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, PestControlScreen.id);
                    },
                    child: ReusableIcons(
                      svgno: 22,
                      text: 'Pest Control',
                    ),
                  ),
                  SizedBox(
                    width: 50.0,
                  ),
                  ReusableIcons(
                    svgno: 23,
                    text: 'Disease Control',
                  ),
                ],
              ),
              SizedBox(
                height: 60.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: ReusableIcons(
                      svgno: 24,
                      text: 'Soil Temperature',
                    ),
                  ),
                  SizedBox(
                    width: 50.0,
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 35.0),
                    child: ReusableIcons(
                      svgno: 25,
                      text: 'Soil Moisture',
                    ),
                  ),
                ],
              ),

              Container(
                margin: EdgeInsets.only(top: 0.46 * width),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/corncrops.png'),
                        Image.asset('assets/images/corncrops.png'),
                        Image.asset('assets/images/corncrops.png'),
                      ],
                    ),
                  ],
                ),
              ),
              // ElevatedButton(
              //     onPressed: () {

              //     },
              //     child: Text())
            ],
          ),
        ),
      ),
      backgroundColor: Color(0xFFF8FFF5),
    );
  }
//   Widget buildMenuItem({
//   required String text,
//   required IconData icon,
// }){
//   final color =Colors.white,
//
//  return ListTile(
//     leading:Icon(icon,color:color),
//     title: Text(text, style: TextStyle(color: color)),
//     );
//
// }
}

class ReusableIcons extends StatelessWidget {
  ReusableIcons({this.svgno, this.text});
  final svgno;
  final text;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          'assets/svgs/Group ${svgno}.svg',
          height: 100,
          width: 100,
        ),
        Text(
          text,
          style: GoogleFonts.poppins(
            fontStyle: FontStyle.normal,
            textStyle: TextStyle(
              fontSize: 18.0,
            ),
          ),
        )
      ],
    );
  }
}

void notify() async {
  AwesomeNotifications().initialize(null, [
    NotificationChannel(
      channelKey: 'key1',
      channelName: 'Krishi-sahayak',
      channelDescription: 'hello',
      defaultColor: Color(0xFF7FCD91),
      playSound: true,
      soundSource: 'assets/sounds/note5.mp3',
      enableVibration: true,
    )
  ]);
  await AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: 1,
          channelKey: 'key1',
          title: 'Notification Title',
          body: 'Notification body',
          bigPicture:
              'https://9to5google.com/wp-content/uploads/sites/4/2021/04/Android-12-6.jpg?quality=82&strip=all',
          notificationLayout: NotificationLayout.BigPicture));
}
