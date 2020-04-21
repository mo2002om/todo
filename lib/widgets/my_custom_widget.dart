
import 'package:flutter/material.dart';

Widget getIconText({Icon icon, String text, VoidCallback onTap}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.fromLTRB(10, 4, 10, 4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.grey.withOpacity(0.2)),
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
