import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:krishi_sahayak/components/drawer.dart';
import 'package:krishi_sahayak/services/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'loginScreen.dart';

class HomeScreen extends StatefulWidget {
  static String id = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String uid;
  late Position position;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<void> getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
    var latitude = location.latitude;
    var longitude = location.longitude;
    uid = FirebaseAuth.instance.currentUser!.uid;
    _firestore.collection('users').doc(uid).set({
      'latitude': latitude,
      'longitude': longitude,
    }, SetOptions(merge: true));
  }

  Future<void> signout() async {
    await _auth.signOut();
    Navigator.pushNamedAndRemoveUntil(
        context, LoginScreen.id, (route) => false);
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
            Container(
              child: Image.asset(
                'assets/images/warning.png',
                fit: BoxFit.contain,
                height: 32,
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
                  ReusableIcons(
                    svgno: 22,
                    text: 'Pest Control',
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
                  ReusableIcons(
                    svgno: 24,
                    text: 'Soil Temperature',
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
              ElevatedButton(
                  onPressed: () async {
                    signout();
                  },
                  child: Text('Logout'))
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
