import 'package:flutter/material.dart';

const kTextFieldDecoration = InputDecoration(
  fillColor: Color(0x3370AF85),
  filled: true,
  hintText: 'Enter a value',
  contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 18.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(10.0),
    ),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFF7FCD91), width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
);
