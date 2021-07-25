import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:krishi_sahayak/components/customDialogBox.dart';
import 'package:krishi_sahayak/components/drawer.dart';

class AlertScreen extends StatefulWidget {
  static String id = 'home_screen';
  const AlertScreen({Key? key}) : super(key: key);

  @override
  _AlertScreenState createState() => _AlertScreenState();
}

class _AlertScreenState extends State<AlertScreen> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
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
                'Past Alerts',
                style: GoogleFonts.poppins(
                  fontStyle: FontStyle.normal,
                  textStyle: TextStyle(
                    fontSize: 22.0,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 75.0),
              child: Image.asset(
                'assets/images/corn.png',
                fit: BoxFit.contain,
                height: 32,
              ),
            ),
          ],
        ),
      ),
      body: StreamBuilder(
        stream: _firestore
            .collection('alertnotif')
            .doc(_auth.currentUser!.uid)
            .collection('userAlerts1')
            .orderBy('date', descending: true)
            .limit(50)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: Text("Loading"));
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;
              print('listview $data');
              return ListTileItem(data: data);
            }).toList(),
          );
        },
      ),
    );
  }
}

class ListTileItem extends StatelessWidget {
  const ListTileItem({
    Key? key,
    required this.data,
  }) : super(key: key);

  final Map<String, dynamic> data;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: new Text(data['body']),
      subtitle: Text(
        data['date'].toDate().toString(),
      ),
    );
  }
}

class AlertItem extends StatelessWidget {
  const AlertItem({
    Key? key,
    required this.width,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.all(17),
      height: 180,
      width: 0.9 * width,
      decoration: BoxDecoration(
        color: Color(0x1570AF85),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset(
                'assets/svgs/pest.svg',
                height: 20,
                width: 20,
              ),
              // Icon(
              //   Icons.pest_control_outlined,
              //   color: Colors.red,
              // ),
              SizedBox(width: 12),
              Text(
                'Pest Alert',
                style: GoogleFonts.poppins(
                  fontStyle: FontStyle.normal,
                  textStyle: TextStyle(
                    fontSize: 19.0,
                  ),
                ),
              ),
              SizedBox(width: 100),
              Text(
                'Today, 11:45am',
                style: GoogleFonts.poppins(
                  fontStyle: FontStyle.normal,
                  textStyle: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                'Possible Pests detected: ',
                style: GoogleFonts.poppins(
                  fontStyle: FontStyle.normal,
                  textStyle: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ),
              SizedBox(width: 5),
              Flexible(
                child: Container(
                  margin: EdgeInsets.only(top: 25),
                  child: Text(
                    'Termites & Jassids ',
                    style: GoogleFonts.poppins(
                      fontStyle: FontStyle.normal,
                      textStyle:
                          TextStyle(fontSize: 18.0, color: Color(0xFFF40E10)),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                'Treatment: ',
                style: GoogleFonts.poppins(
                  fontStyle: FontStyle.normal,
                  textStyle: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ),
              SizedBox(width: 5),
              Text(
                'MPK ',
                style: GoogleFonts.poppins(
                  fontStyle: FontStyle.normal,
                  textStyle:
                      TextStyle(fontSize: 18.0, color: Color(0xFFF40E10)),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
