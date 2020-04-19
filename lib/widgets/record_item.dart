
import 'package:flutter/material.dart';

class RecordItem extends StatelessWidget {
  const RecordItem({
    Key key,
    @required Color fontColor,
    @required double smallFontSpacing,
    @required this.day,
  })  : _fontColor = fontColor,
        _smallFontSpacing = smallFontSpacing,
        super(key: key);

  final Color _fontColor;
  final double _smallFontSpacing;
  final String day;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                color: Color(0xffdde9f7),
                width: 1.5,
              ))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            day,
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w700, color: _fontColor),
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: <Widget>[
              Text(
                "01/21/2019",
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    letterSpacing: _smallFontSpacing,
                    color: _fontColor),
              ),
              SizedBox(
                width: 25,
              ),
              Expanded(
                child: Text(
                  "45.3 MINUTES",
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      letterSpacing: _smallFontSpacing,
                      color: _fontColor),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
