import 'dart:math';

import 'package:flutter/material.dart';

Color randomColor() {
  var random = new Random();
  double a = 1.0; // Assuming you want full opacity every time.
  var r = random.nextInt(256); // red = 0..255
  var g = random.nextInt(256); // green = 0..255
  var b = random.nextInt(256); // blue = 0..255
  return Color.fromRGBO(r, g, b, a);
}

Color colorImportant({int index}){
  switch(index){
    case 0:
      return Colors.redAccent;
      break;
    case 1:
      return Colors.teal;
      break;
    case 2:
      return Colors.orangeAccent;
      break;
    default:
      return Colors.redAccent;
  }
}