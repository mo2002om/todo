
import 'package:flutter/material.dart';

Widget getIconText({Icon icon, String text, VoidCallback onTap ,Color color = Colors.grey}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.fromLTRB(10, 4, 10, 4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: color.withOpacity(0.2)),
      child: Row(
        children: <Widget>[
          icon,
          SizedBox(
            width: 4,
          ),
          Text(text),
        ],
      ),
    ),
  );
}
