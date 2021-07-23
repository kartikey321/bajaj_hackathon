import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:krishi_sahayak/components/drawer.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;
final ImagePicker _picker = ImagePicker();
final FirebaseStorage _storage = FirebaseStorage.instance;

class ProfileScreen extends StatefulWidget {
  static String id = 'profile_screen';

  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String _currentAddress;
  late String name;
  late String phoneNo;
  late double latitude;
  late double longitude;
  late String address;
  XFile? image1;
  File? image2;
  String? url2;
  Future<void> getinfo() async {
    await getProfileImage();
    await _fetch().whenComplete(() {
      setState(() {});
    });
  }

  @override
  void initState() {
    getinfo();
    super.initState();
  }

  void _showPicker(context) {
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          Future<void> _pickImage(ImageSource source) async {
            final image = await _picker.pickImage(
                source: source, maxWidth: 150.0, maxHeight: 150.0);
            if (image != null) {
              await _storage
                  .ref('profileImages/${_auth.currentUser!.uid}')
                  .putFile(File(image.path));

              final url = await _storage
                  .ref('profileImages/${_auth.currentUser!.uid}')
                  .getDownloadURL();

              setState(() {
                url2 = url;
              });

              // e.g, e.code == 'canceled'
            }
          }

          return SafeArea(
            child: Container(
              child: new Wrap(
                children: [
                  ListTile(
                    leading: Icon(Icons.photo_library),
                    title: Text('From Gallery'),
                    onTap: () {
                      _pickImage(ImageSource.gallery);
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.photo_camera),
                    title: Text('Camera'),
                    onTap: () {
                      _pickImage(ImageSource.camera);
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xFFF8FFF5),
      drawer: Drawer1,
      appBar: AppBar(
        backgroundColor: Color(0xFF7FCD91),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/corn.png',
              fit: BoxFit.contain,
              height: 32,
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Profile',
                style: GoogleFonts.poppins(
                  fontStyle: FontStyle.normal,
                  textStyle: TextStyle(
                    fontSize: 22.0,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 35.0),
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
              GestureDetector(
                onTap: () {
                  _showPicker(context);
                },
                child: Container(
                  margin: EdgeInsets.only(top: 50),
                  width: 150.0,
                  height: 150.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(
                      0xFF9DDAAA,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(75),
                    // child: FutureBuilder(
                    //   future: getProfileImage(),
                    //   builder: (context, snapshot) {
                    //     if (snapshot.connectionState != ConnectionState.done)
                    //       return SvgPicture.asset(
                    //         'assets/svgs/profile.svg',
                    //         height: 150.0,
                    //         width: 150.0,
                    //       );

                    //     return Image.file(
                    //       image2!,
                    //       fit: BoxFit.cover,
                    //     );
                    //   },
                    // ),
                    child: url2 != null
                        ? Image.network(url2!)
                        : SvgPicture.asset(
                            'assets/svgs/profile.svg',
                            height: 150.0,
                            width: 150.0,
                          ),
                  ),
                ),
              ),
              SizedBox(
                height: 55.0,
              ),
              Container(
                padding: EdgeInsets.all(12.0),
                width: 0.8 * width,
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(12.0),
                    color: Color(0xFFF8FFF5),
                    border: Border.all(
                      color: Color(0xFF7FCD91),
                      width: 1,
                    )),
                child: Row(
                  children: [
                    Text(
                      'Name:',
                      style: GoogleFonts.poppins(
                        fontStyle: FontStyle.normal,
                        textStyle: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    FutureBuilder(
                      future: _fetch(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState != ConnectionState.done)
                          return Text('Loading data... Please wait');
                        return Text(
                          name,
                          style: GoogleFonts.poppins(
                            fontStyle: FontStyle.normal,
                            textStyle: TextStyle(
                              color: Color(0xFF7FCD91),
                              fontSize: 18.0,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 25.0,
              ),
              Container(
                padding: EdgeInsets.all(12.0),
                width: 0.8 * width,
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(12.0),
                    color: Color(0xFFF8FFF5),
                    border: Border.all(
                      color: Color(0xFF7FCD91),
                      width: 1,
                    )),
                child: Row(
                  children: [
                    Text(
                      'Location:',
                      style: GoogleFonts.poppins(
                        fontStyle: FontStyle.normal,
                        textStyle: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    FutureBuilder(
                      future: _fetch(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState != ConnectionState.done)
                          return Text('Loading data... Please wait');
                        return Flexible(
                          child: Text(
                            _currentAddress,
                            style: GoogleFonts.poppins(
                              fontStyle: FontStyle.normal,
                              textStyle: TextStyle(
                                color: Color(0xFF7FCD91),
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 25.0,
              ),
              Container(
                padding: EdgeInsets.all(12.0),
                width: 0.8 * width,
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(12.0),
                    color: Color(0xFFF8FFF5),
                    border: Border.all(
                      color: Color(0xFF7FCD91),
                      width: 1,
                    )),
                child: Row(
                  children: [
                    Text(
                      'PhoneNo:',
                      style: GoogleFonts.poppins(
                        fontStyle: FontStyle.normal,
                        textStyle: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    FutureBuilder(
                      future: _fetch(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState != ConnectionState.done)
                          return Text('Loading data... Please wait');
                        return Text(
                          phoneNo,
                          style: GoogleFonts.poppins(
                            fontStyle: FontStyle.normal,
                            textStyle: TextStyle(
                              color: Color(0xFF7FCD91),
                              fontSize: 18.0,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 80,
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(20, 0, 0.37 * width, 20),
                  child: Image.asset(
                    'assets/images/tractor.png',
                    height: 260,
                    width: 260,
                  )),
            ],
          ),
        ),
      ),
    );
  }

  _getAddressFromLatLng(latitude, longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);

      Placemark place = placemarks[0];

      _currentAddress =
          "${place.subLocality},${place.locality},${place.name}, ${place.postalCode}, ${place.country}";
    } catch (e) {
      print(e);
    }
  }

  _fetch() async {
    if (_auth.currentUser != null) {
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .get()
          .then((ds) {
        name = ds.data()!['name'];
        phoneNo = ds.data()!['phoneNo'];
        latitude = ds.data()!['latitude'];
        longitude = ds.data()!['longitude'];
        _getAddressFromLatLng(latitude, longitude);
      });
    }
  }

  Future<void> getProfileImage() async {
    File? img;
    final url = await _storage
        .ref('profileImages/${_auth.currentUser!.uid}')
        .getDownloadURL();
    url2 = url;
    image2 = img;
  }
}
