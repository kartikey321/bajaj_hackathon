import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFF8FFF5),
      child: Center(
        child: SpinKitDoubleBounce(
          color: Color(0xFF70AF85),
          size: 150.0,
        ),
      ),
    );
  }
}
