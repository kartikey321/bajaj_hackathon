import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:krishi_sahayak/screens/OnboardingScreen.dart';
import 'package:krishi_sahayak/screens/pestControlScreen.dart';
import 'package:krishi_sahayak/screens/settingsScreen.dart';
import 'package:krishi_sahayak/screens/signupScreen.dart';
import 'package:krishi_sahayak/screens/splashScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:translator/translator.dart';

import 'screens/aboutScreen.dart';
import 'screens/homeScreen.dart';
import 'screens/loginScreen.dart';
import 'screens/profileScreen.dart';
import 'screens/signupScreen.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
final FlutterTts flutterTts = FlutterTts();
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
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

  await Firebase.initializeApp();
  print('A bg message just showed up :  ${message.messageId}');
  print('Notification is ${message.notification!.title}');
  //notify();
  //AwesomeNotifications().createNotificationFromJsonData(message.data);
}

bool? initScreen;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  initScreen = await prefs.getBool('initScreen');
  await prefs.setBool('initScreen', true);
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
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: initScreen! || initScreen == null
          ? OnboardingScreen()
          : LoginScreen(),
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
        SignupScreen.id: (context) => SignupScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        ProfileScreen.id: (context) => ProfileScreen(),
        AboutScreen.id: (context) => AboutScreen(),
        SettingsScreen.id: (context) => SettingsScreen(),
        PestControlScreen.id: (context) => PestControlScreen(),
        SplashScreen.id: (context) => SplashScreen(),
        OnboardingScreen.id: (context) => OnboardingScreen(),
      },
    );
  }
}

void notify() async {
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
