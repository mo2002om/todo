import 'package:flutter/material.dart';

class MyWidgetButton extends StatefulWidget {
  final VoidCallback onPressed;
  final Color shadowColor, color,textColor;
  final String title;
  const MyWidgetButton({
    Key key,
    @required this.onPressed,
    @required this.shadowColor,
    @required this.color,
    @required this.title, this.textColor = Colors.black,
  }) : super(key: key);
  @override
  _MyWidgetButtonState createState() => _MyWidgetButtonState();
}

class _MyWidgetButtonState extends State<MyWidgetButton> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        new Container(
          margin: const EdgeInsets.only(left: 24,right: 24,top: 10),
          child: new GestureDetector(
            onTap: widget.onPressed,
            child: new Material(
              borderRadius: BorderRadius.circular(8.0),
              shadowColor:  widget.shadowColor,
              color: widget.color,
              elevation: 2.0,
              child: new Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Text(
                    widget.title ,
                    style: Theme.of(context).textTheme.body2.copyWith(fontWeight: FontWeight.bold,color: widget.textColor),
                  ),
                ),
              ),
            ),
          ),
        ),
        new SizedBox(height: 8,),
      ],
    );
  }

}

class MyButtonAndIcon extends StatelessWidget {
  final VoidCallback onPressed;
  final Color shadowColor, color;
  final String title;
  final IconData iconData;
  const MyButtonAndIcon({Key key, this.onPressed, this.shadowColor, this.color, this.title, this.iconData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.all(5.0),
      child: new GestureDetector(
        onTap: onPressed,
        child: new Material(
          borderRadius: BorderRadius.circular(4.0),
          shadowColor:  shadowColor,
          color: color,
          elevation: 3.0,
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Row(
              children: <Widget>[
                new Icon(iconData,color: Colors.white,),
                new Expanded(
                  child: new Text(
                    title ,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).primaryTextTheme.body2.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyTabBarText extends StatelessWidget {
  final VoidCallback onPressed;
  final Color textColor, color;
  final String title;
  const MyTabBarText({Key key,@required this.onPressed,@required this.textColor,@required this.color,@required this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.all(5.0),
        padding: const EdgeInsets.all(5.0),
        color: color,
        child: new Text(
          title ,
          textAlign: TextAlign.center,
          style: Theme.of(context).primaryTextTheme.body2.copyWith(fontWeight: FontWeight.bold,color: textColor),
        ),


      ),
    );
  }
}

