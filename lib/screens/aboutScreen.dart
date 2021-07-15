import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:krishi_sahayak/components/drawer.dart';

class AboutScreen extends StatefulWidget {
  static String id = 'About_screen';
  const AboutScreen({Key? key}) : super(key: key);

  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
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
                'About Us',
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
      body: SingleChildScrollView(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(12.0, 45.0, 19.0, 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 8,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          'Monitor your farm on your',
                          style: GoogleFonts.poppins(
                            fontStyle: FontStyle.normal,
                            textStyle: TextStyle(
                              fontSize: 19.5,
                            ),
                          ),
                        ),
                        Text(
                          'fingertips',
                          style: GoogleFonts.poppins(
                            fontStyle: FontStyle.normal,
                            textStyle: TextStyle(
                              fontSize: 19.5,
                              color: Color(0xFFF65A6E),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                      flex: 4,
                      child: Container(
                          height: 75.0,
                          width: 75.0,
                          margin: EdgeInsets.only(
                            left: 17.0,
                          ),
                          child: SvgPicture.asset(
                            'assets/svgs/phone.svg',
                            height: 75.0,
                            width: 55.0,
                            fit: BoxFit.cover,
                          ))),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(12.0, 35.0, 19.0, 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Flexible(
                      flex: 4,
                      child: Container(
                          height: 60.0,
                          width: 60.0,
                          margin: EdgeInsets.only(right: 17.0, left: 10),
                          child: SvgPicture.asset(
                            'assets/svgs/globe.svg',
                            height: 55.0,
                            width: 55.0,
                            fit: BoxFit.cover,
                          ))),
                  Flexible(
                    flex: 8,
                    child: Container(
                      margin: EdgeInsets.only(left: 25),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            'Get real time alerts,',
                            style: GoogleFonts.poppins(
                              fontStyle: FontStyle.normal,
                              textStyle: TextStyle(
                                fontSize: 19.2,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                'anytime, ',
                                style: GoogleFonts.poppins(
                                  fontStyle: FontStyle.normal,
                                  textStyle: TextStyle(
                                    fontSize: 19.2,
                                  ),
                                ),
                              ),
                              Text(
                                'anywhere',
                                style: GoogleFonts.poppins(
                                  fontStyle: FontStyle.normal,
                                  textStyle: TextStyle(
                                    fontSize: 19.2,
                                    color: Color(0xFFF65A6E),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(12.0, 35.0, 19.0, 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 8,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          'Resolve problems as soon',
                          style: GoogleFonts.poppins(
                            fontStyle: FontStyle.normal,
                            textStyle: TextStyle(
                              fontSize: 19.5,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              'as ',
                              style: GoogleFonts.poppins(
                                fontStyle: FontStyle.normal,
                                textStyle: TextStyle(
                                  fontSize: 19.5,
                                ),
                              ),
                            ),
                            Text(
                              'you see them',
                              style: GoogleFonts.poppins(
                                fontStyle: FontStyle.normal,
                                textStyle: TextStyle(
                                  fontSize: 19.5,
                                  color: Color(0xFFF65A6E),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                      flex: 4,
                      child: Container(
                          height: 75.0,
                          width: 75.0,
                          margin: EdgeInsets.only(
                            left: 17.0,
                          ),
                          child: SvgPicture.asset(
                            'assets/svgs/health.svg',
                            height: 75.0,
                            width: 55.0,
                            fit: BoxFit.cover,
                          ))),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(12.0, 35.0, 19.0, 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Flexible(
                      flex: 4,
                      child: Row(
                        children: [
                          Flexible(
                            child: Container(
                                height: 60.0,
                                width: 60.0,
                                margin: EdgeInsets.only(right: 5, left: 10),
                                child: SvgPicture.asset(
                                  'assets/svgs/money.svg',
                                  height: 55.0,
                                  width: 55.0,
                                  fit: BoxFit.cover,
                                )),
                          ),
                          Flexible(
                            child: Container(
                                height: 60.0,
                                width: 60.0,
                                margin: EdgeInsets.only(right: 10, left: 2),
                                child: SvgPicture.asset(
                                  'assets/svgs/leaf.svg',
                                  height: 55.0,
                                  width: 55.0,
                                  fit: BoxFit.cover,
                                )),
                          )
                        ],
                      )),
                  Flexible(
                    flex: 8,
                    child: Container(
                      margin: EdgeInsets.only(left: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 10, top: 15),
                            child: Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    'Grow better, Earn ',
                                    style: GoogleFonts.poppins(
                                      fontStyle: FontStyle.normal,
                                      textStyle: TextStyle(
                                        fontSize: 19.2,
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  'better',
                                  style: GoogleFonts.poppins(
                                    fontStyle: FontStyle.normal,
                                    textStyle: TextStyle(
                                      fontSize: 19.2,
                                      color: Color(0xFFF65A6E),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
              width: 0.8 * width,
              child: Divider(
                thickness: 2,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Krishi Sahayak',
                        style: GoogleFonts.poppins(
                          fontStyle: FontStyle.normal,
                          textStyle: TextStyle(
                            fontSize: 19.2,
                            color: Color(0xFF49DE69),
                          ),
                        ),
                      ),
                      Text(
                        ' is a farm monitoring app',
                        style: GoogleFonts.poppins(
                          fontStyle: FontStyle.normal,
                          textStyle: TextStyle(
                            fontSize: 19.2,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'that gives you alerts about crop damage as soon as the sensors detect it. ',
                    style: GoogleFonts.poppins(
                      fontStyle: FontStyle.normal,
                      textStyle: TextStyle(
                        fontSize: 19.2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(
                        'Get ',
                        style: GoogleFonts.poppins(
                          fontStyle: FontStyle.normal,
                          textStyle: TextStyle(
                            fontSize: 19.2,
                          ),
                        ),
                      ),
                      Text(
                        'recomendations ',
                        style: GoogleFonts.poppins(
                          fontStyle: FontStyle.normal,
                          textStyle: TextStyle(
                            fontSize: 19.2,
                            color: Color(0xFFF65A6E),
                          ),
                        ),
                      ),
                      Text(
                        'on the four most',
                        style: GoogleFonts.poppins(
                          fontStyle: FontStyle.normal,
                          textStyle: TextStyle(
                            fontSize: 19.2,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'important parameters of farming- Pest, disease, soil moisture and soil temperature.',
                    style: GoogleFonts.poppins(
                      fontStyle: FontStyle.normal,
                      textStyle: TextStyle(
                        fontSize: 19.2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: SizedBox(
                      height: 40,
                      child: Divider(
                        thickness: 2,
                      ),
                    ),
                  ),
                  SvgPicture.asset(
                    'assets/svgs/biCorns.svg',
                    height: 40,
                    width: 40,
                  ),
                  Flexible(
                    child: SizedBox(
                      height: 40,
                      child: Divider(
                        thickness: 2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Meet the ',
                        style: GoogleFonts.poppins(
                          fontStyle: FontStyle.normal,
                          textStyle: TextStyle(
                              fontSize: 23.2, fontWeight: FontWeight.w800),
                        ),
                      ),
                      Text(
                        'Team ',
                        style: GoogleFonts.poppins(
                          fontStyle: FontStyle.normal,
                          textStyle: TextStyle(
                              fontSize: 23.2,
                              color: Color(0xFFF65A6E),
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Ra\'s-al-ghul',
                    style: GoogleFonts.poppins(
                      fontStyle: FontStyle.normal,
                      textStyle: TextStyle(
                          fontSize: 23.2,
                          color: Color(0xFF7FCD91),
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              margin: EdgeInsets.symmetric(horizontal: 26, vertical: 15),
            ),
            TeamWidget(
              svgpath: 'assets/images/viraj.jpeg',
              name: 'Viraj Agarwal',
              description: 'Web dev guru who agrees to pretty much everything.',
            ),
            TeamWidget(
              svgpath: 'assets/images/vedant.jpeg',
              name: 'Vedant Singh',
              description:
                  'Sleep deprived front end and design guy who can bring any idea to life.',
            ),
            TeamWidget(
              svgpath: 'assets/images/kartikey.jpeg',
              name: 'Kartikey Mahawar',
              description:
                  'App developer with a solution for anything and excellent comic timing. ',
            ),
            TeamWidget(
              svgpath: 'assets/images/parth.jpeg',
              name: 'Parth Katiyar',
              description:
                  'Quick witted, extra calm ML-wiz with a dash of humour.',
            ),
            TeamWidget(
              svgpath: 'assets/images/bhurva.jpeg',
              name: 'Bhurva Sharma',
              description:
                  'UI/UX design, frontend,content and chronic cookie baker.',
            ),
            Container(
              margin: EdgeInsets.only(top: 0.2 * width),
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
          ],
        ),
      )),
    );
  }
}

class TeamWidget extends StatelessWidget {
  TeamWidget(
      {required this.svgpath, required this.name, required this.description});
  final String svgpath;
  final String name;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Column(
        children: [
          Container(
            width: 120,
            child: CircleAvatar(
              radius: 60,
              backgroundColor: Colors.white,
              backgroundImage: ExactAssetImage(svgpath),
            ),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Color(0xFF7FCD91),
                  width: 3.0,
                )),
          ),
          SizedBox(height: 5),
          Text(
            name,
            style: GoogleFonts.poppins(
              fontStyle: FontStyle.normal,
              textStyle: TextStyle(
                fontSize: 19.2,
                color: Color(0xFFF65A6E),
              ),
            ),
          ),
          SizedBox(height: 5),
          Text(
            description,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontStyle: FontStyle.normal,
              textStyle: TextStyle(
                fontSize: 19.2,
                color: Color(0xFF28527A),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
