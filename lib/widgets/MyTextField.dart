

import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final IconData icon;
  final String textValue;
  final String hintText;
  final String startText;
  final TextInputType keyboardType;
  final Color nColor;
  final Color bColor;
  final bool obscureText;
  final Color iconColor;
  const MyTextField({Key key, this.onChanged, this.icon, this.hintText , this.keyboardType = TextInputType.text,this.obscureText = false,this.startText = "",this.textValue = "", this.nColor = Colors.black, this.bColor = Colors.white, this.iconColor = Colors.black}) : super(key: key);

  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  TextEditingController _editingController;
  @override
  void initState() {
    super.initState();
    _editingController = new TextEditingController(text: widget.textValue);
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 44,
      margin: const EdgeInsets.only(left: 16,right: 16),

      child: new Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          new Container(
            width: 56,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(color: widget.nColor),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),

              ),
              color: widget.bColor,

            ),
            child: new Icon(widget.icon,size: 32,color: widget.iconColor,),
          ),
          new Container(
            width: 1,
            decoration: BoxDecoration(
              color: widget.bColor,
            ),
          ),
          new Container(
            width: 2,
            decoration: BoxDecoration(
              color: Colors.transparent,
            ),
          ),
          new Container(
            width: 1,
            decoration: BoxDecoration(
              color: widget.bColor,
            ),
          ),
          new Expanded(
            child: new Container(
              decoration: BoxDecoration(
                border: Border.all(color: widget.nColor),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
                color: Colors.white,
              ),
              padding: const EdgeInsets.only(left: 0,right: 10),
              child: Row(
                children: <Widget>[
                  widget.startText != "" ? Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: new Text(widget.startText),
                  ) : new Container(),
                  new Expanded(
                    child: TextField(
                      controller: _editingController,
                      textAlign: TextAlign.center,
                      keyboardType: widget.keyboardType,
                      obscureText: widget.obscureText,
                      style: TextStyle(fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: widget.hintText,
                        hintStyle: TextStyle(color: Colors.black),
                      ),
                      onChanged: (String value) {
                        widget.onChanged(value);
                      },
                      onSubmitted: (String value){
                        widget.onChanged(value);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
