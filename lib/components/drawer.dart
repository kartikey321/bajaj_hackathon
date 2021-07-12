import 'package:flutter/material.dart';
import 'package:krishi_sahayak/screens/homeScreen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
      leading: Icon(Icons.home, color: color),
      title: Text(text, style: TextStyle(color: color)),
      onTap: () {
        Navigator.pushNamed(context, screenid);
      },
    );
  }
}
