import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';
import 'package:todo/widgets/my_widget_button.dart';

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

Future circleColorPicker(BuildContext context, String title,Color colorOld) {
  Color colorNew = colorOld;
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new SimpleDialog(
          contentPadding: const EdgeInsets.all(8),
          title:new Text(title, style: TextStyle(color: Colors.black),textAlign: TextAlign.center) ,
          children: <Widget>[
            Center(
              child: CircleColorPicker(
                initialColor: colorOld,
                onChanged: (color) {
                  colorNew = color;
                },
                size: const Size(240, 240),
                strokeWidth: 4,
                thumbSize: 24,
              ),
            ),
            new MyWidgetButton(
              onPressed: (){
                Navigator.pop(context,colorNew);
              },
              shadowColor: Theme.of(context).primaryColor,
              color: Theme.of(context).primaryColor,
              title: "موافق",
              textColor: Theme.of(context).primaryTextTheme.body2.color,
            ),
            new MyWidgetButton(
              onPressed: (){
                Navigator.pop(context);
              },
              shadowColor: Theme.of(context).primaryColor,
              color: Theme.of(context).primaryColor,
              title: "إلغاء",
              textColor: Theme.of(context).primaryTextTheme.body2.color,
            ),
          ],
        );
      }
  );
}
