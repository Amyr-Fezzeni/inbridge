import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//style

const lightPanelColor = Color.fromARGB(255, 55, 72, 144);
const darkPanelColor = Color.fromARGB(255, 16, 21, 51);

const lightBgColor = Color.fromARGB(255, 255, 255, 255);
const darkBgColor = Color.fromARGB(255, 35, 45, 55);

const lightnavBarColor = Color.fromARGB(255, 255, 255, 255);
const darknavBarColor = Color.fromARGB(255, 41, 41, 41);

const primaryGradient = [
  Color.fromARGB(255, 82, 113, 255),
  Color.fromARGB(255, 91, 121, 251)
];
const secondGradient = [
  Color.fromRGBO(213, 116, 10, 1),
  Color.fromRGBO(228, 150, 67, 1)
];

const categoryGradient = [
  Color.fromRGBO(1, 114, 180, 1),
  Color.fromRGBO(180, 214, 240, 1)
];

final defaultShadow = [
  BoxShadow(
      offset: const Offset(2, 2),
      color: Colors.black.withOpacity(.3),
      blurRadius: 4)
];

const double smallRadius = 8;
const double bigRadius = 20;

// text
TextStyle text18black =
    GoogleFonts.poppins(color: Colors.black87, fontSize: 14);
TextStyle text18white = GoogleFonts.poppins(color: Colors.white, fontSize: 14);
TextStyle titleWhite = GoogleFonts.poppins(
    color: Colors.white, fontSize: 35, fontWeight: FontWeight.w800);
TextStyle titleblack = GoogleFonts.poppins(
    color: Colors.black87, fontSize: 35, fontWeight: FontWeight.w800);



//colors
const pink = Color.fromARGB(255, 255, 117, 142);
const red = Color.fromARGB(213, 180, 7, 65);
const darkRed = Color.fromARGB(255, 159, 11, 0);
Color darkGray = const Color.fromARGB(255, 53, 53, 53);


