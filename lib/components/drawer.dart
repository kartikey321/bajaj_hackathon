import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:krishi_sahayak/screens/aboutScreen.dart';
import 'package:krishi_sahayak/screens/homeScreen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:krishi_sahayak/screens/loginScreen.dart';
import 'package:krishi_sahayak/screens/profileScreen.dart';

var Drawer1 = Drawer(
  child: Container(
    color: Color(0xFF7FCD91),
    child: ListView(
      children: <Widget>[
        const SizedBox(
          height: 48,
        ),
        BuildMenuItem(
          text: 'Home',
          icon: Icons.home,
          screenid: HomeScreen.id,
        ),
        BuildMenuItem(
          text: 'Profile',
          icon: FontAwesomeIcons.user,
          screenid: ProfileScreen.id,
        ),
        BuildMenuItem(
          text: 'About',
          icon: FontAwesomeIcons.info,
          screenid: AboutScreen.id,
        ),
        Logout(),

        //buildMenuItem(text: 'Home', icon: Icons.home),
      ],
    ),
  ),
);

class BuildMenuItem extends StatelessWidget {
  BuildMenuItem(
      {required this.text, required this.icon, required this.screenid});
  final String text;
  final IconData icon;
  final String screenid;

  @override
  Widget build(BuildContext context) {
    final color = Colors.white;
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(
        text,
        style: GoogleFonts.poppins(
          fontStyle: FontStyle.normal,
          textStyle: TextStyle(fontSize: 22.0, color: Colors.white),
        ),
      ),
      onTap: () {
        Navigator.pushNamed(context, screenid);
      },
    );
  }
}

class Logout extends StatefulWidget {
  const Logout({Key? key}) : super(key: key);

  @override
  _LogoutState createState() => _LogoutState();
}

class _LogoutState extends State<Logout> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signout() async {
    await _auth.signOut();
    Navigator.pushNamedAndRemoveUntil(
        context, LoginScreen.id, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Container(
      margin: EdgeInsets.only(top: 0.62 * height),
      child: ListTile(
        leading: Icon(Icons.logout, color: Colors.white),
        title: Text(
          'Logout',
          style: GoogleFonts.poppins(
            fontStyle: FontStyle.normal,
            textStyle: TextStyle(fontSize: 22.0, color: Colors.white),
          ),
        ),
        onTap: () {
          signout();
        },
      ),
    );
  }
}
