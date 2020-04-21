import 'package:flutter/material.dart';
import 'package:todo/app_localizations.dart';
import 'package:todo/models/menu_object.dart';
import 'package:todo/ui/detail_page.dart';
import 'package:todo/utils/utils_string.dart';

class MenuObjectCell extends StatefulWidget {
  final MenuObject menu;
  final VoidCallback onShow;

  const MenuObjectCell({Key key, this.menu,@required this.onShow}) : super(key: key);
  @override
  _MenuObjectCellState createState() => _MenuObjectCellState();
}

class _MenuObjectCellState extends State<MenuObjectCell> {
  @override
  Widget build(BuildContext context) {
    double percentComplete = widget.menu.percentComplete();
    return Padding(
      padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 30.0),
      child: InkWell(
        onTap: () {
          widget.onShow();
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withAlpha(70),
                    offset: Offset(3.0, 10.0),
                    blurRadius: 15.0)
              ]),
          height: 250.0,
          child: Stack(
            children: <Widget>[
              Hero(
                tag: widget.menu.id + "_background",
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      flex: 10,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Hero(
                                tag: widget.menu.id + "_icon",
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: widget.menu.themeMenu.color,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: Colors.black.withAlpha(70),
                                        style: BorderStyle.solid,
                                        width: 1.0),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(widget.menu.themeMenu.icon,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                    Hero(
                      tag: widget.menu.id + "_number_of_tasks",
                      child: Material(
                          color: Colors.transparent,
                          child: Text(
                            widget.menu.tasks.length.toString() + getTranslated(context, "tasks"),
                            style: TextStyle(),
                            softWrap: false,
                          )),
                    ),
                    Spacer(),
                    Hero(
                      tag: widget.menu.id + "_title",
                      child: Material(
                        color: Colors.transparent,
                        child: Text(
                          getTranslated(context, widget.menu.name),
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                          softWrap: false,
                        ),
                      ),
                    ),
                    Spacer(),
                    Hero(
                      tag: widget.menu.id + "_progress_bar",
                      child: Material(
                        color: Colors.transparent,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: LinearProgressIndicator(
                                value: percentComplete,
                                backgroundColor: Colors.grey.withAlpha(50),
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    widget.menu.themeMenu.color),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 5.0),
                              child: Text((percentComplete * 100).round().toString() + "%"),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
