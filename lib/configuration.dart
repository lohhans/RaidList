import 'package:flutter/material.dart';

Color primaryRed = Color(0xffc82308);

Map<int, Color> colorCodes = {
  50: Color.fromRGBO(200, 35, 8, .1),
  100: Color.fromRGBO(200, 35, 8, .2),
  200: Color.fromRGBO(200, 35, 8, .3),
  300: Color.fromRGBO(200, 35, 8, .4),
  400: Color.fromRGBO(200, 35, 8, .5),
  500: Color.fromRGBO(200, 35, 8, .6),
  600: Color.fromRGBO(200, 35, 8, .7),
  700: Color.fromRGBO(200, 35, 8, .8),
  800: Color.fromRGBO(200, 35, 8, .9),
  900: Color.fromRGBO(200, 35, 8, 1),
};
// Red color code: c82308
MaterialColor customRed = MaterialColor(0xFFc82308, colorCodes);

List<BoxShadow> shadowList = [
  BoxShadow(color: Colors.red[300], blurRadius: 30, offset: Offset(0, 10)),
];
