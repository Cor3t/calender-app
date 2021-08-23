import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
    backgroundColor: Color(121212),
    scaffoldBackgroundColor: Color(121212),
    textTheme: TextTheme(bodyText2: TextStyle(color: Colors.white)));

ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    backgroundColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    textTheme: TextTheme(bodyText2: TextStyle(color: Colors.black)));

List<String> months = [
  "January",
  "Febuary",
  "March",
  "April",
  "May",
  "June",
  "July",
  "August",
  "September",
  "October",
  "November",
  "December"
];

List<String> weeks = [
  "MONDAY",
  "TUESDAY",
  "WEDNESDAY",
  "THURSDAY",
  "FRIDAY",
  "SATURDAY",
  "SUNDAY"
];

screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
screenHeight(BuildContext context) => MediaQuery.of(context).size.height;

var boldSubHeading =
    TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18);
