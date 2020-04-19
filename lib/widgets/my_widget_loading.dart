
import 'package:flutter/material.dart';

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
            new MyTextBody(string: "انتظر قليلا",color: Colors.white),
          ],
        ),
      ),
    );
  }
}

class MyWidgetNull extends StatelessWidget {
  final String message;
  const MyWidgetNull({Key key, this.message = "لا توجد بيانات"}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Icon(Icons.sentiment_dissatisfied,size: 64,color: Colors.black,),
            new MyTextBody(string: message,color: Colors.black),
          ],
        ),
      ),
    );
  }
}

