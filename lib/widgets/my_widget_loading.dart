
import 'package:flutter/material.dart';
import 'package:todo/app_localizations.dart';

import 'modal_text_widgets.dart';

class MyWidgetLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Icon(Icons.sentiment_satisfied,size: 64,color: Colors.white,),
            new MyTextBody(string: getTranslated(context, "wait"),color: Colors.white),
          ],
        ),
      ),
    );
  }
}

class MyWidgetNull extends StatelessWidget {
  final String message;
  final Color color;
  const MyWidgetNull({Key key, this.message = "noData", this.color = Colors.black}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Icon(Icons.sentiment_dissatisfied,size: 64,color: color,),
            new MyTextBody(string: getTranslated(context, message),color: color),
          ],
        ),
      ),
    );
  }
}

