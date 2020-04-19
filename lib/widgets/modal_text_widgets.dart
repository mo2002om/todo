

import 'package:flutter/material.dart';

class MyTextBody extends StatelessWidget {
  final String string;
  final Color color;
  final TextAlign textAlign;
  const MyTextBody({Key key, this.string,this.color = Colors.black, this.textAlign = TextAlign.center}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Text(
        string,
        textAlign: textAlign,
        style: Theme.of(context).textTheme.body2.copyWith(fontWeight: FontWeight.bold,color: color),
      ),
    );
  }
}

class MyTextCaption extends StatelessWidget {
  final String string;
  final Color color;
  final TextAlign textAlign;
  const MyTextCaption({Key key, this.string,this.color, this.textAlign = TextAlign.center}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Text(
        string,
        textAlign: textAlign,
        style: Theme.of(context).textTheme.caption.copyWith(fontWeight: FontWeight.bold ,color: color == null ? Theme.of(context).textTheme.caption.color : color),
      ),
    );
  }
}