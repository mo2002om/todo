
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/utils/utils_string.dart';

import 'helpers/base_element.dart';
import 'task_object.dart';

class MenuObject extends FireBaseElement {
  static final String nameCollection = "menus";
  int timestamp;
  String name;
  MenuObject(
      {
        this.name,
        this.timestamp,
        id})
      : super(id, nameCollection);

  @override
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      "name": this.name,
      "timestamp": this.timestamp ?? new DateTime.now().millisecondsSinceEpoch,
    };
    if (this.id != null) {
      map["id"] = id;
    }else{
      map["id"] = createId();
    }
    return map;
  }
  static MenuObject getMenuObject() {
    MenuObject menuObject = new MenuObject(
      name: "",
      timestamp: new DateTime.now().millisecondsSinceEpoch,
    );
    return menuObject;
  }

  @override
  void createTable(Database db) {
    db.rawUpdate("CREATE TABLE $nameCollection ("
        "id varchar(30) primary key,"
        "name varchar(30) ,"
        "timestamp integer"
        ")");
  }

  factory MenuObject.sqlFromMap(Map<String, dynamic> map){
    MenuObject menuObject = MenuObject(
      id: map["id"],
      name: map["name"],
      timestamp: map["timestamp"],
    );
    return menuObject;
  }

  @override
  List<String> columns() {
    return ["id","name","timestamp"];
  }
}

List<MenuObject> listMenus = [
  new MenuObject(id: createId(),name: "الصلاة" ,timestamp: new DateTime.now().millisecondsSinceEpoch),
  new MenuObject(id: createId(),name: "العمل" ,timestamp: new DateTime.now().millisecondsSinceEpoch),
  new MenuObject(id: createId(),name: "التعليم" ,timestamp: new DateTime.now().millisecondsSinceEpoch),

];


class ColorChoice {
  ColorChoice({@required this.primary, @required this.gradient});

  final Color primary;
  final List<Color> gradient;
}

class ColorChoices {
  static List<ColorChoice> choices = [
    ColorChoice(
      primary: Color(0xFFF77B67),
      gradient: [
        Color.fromRGBO(245, 68, 113, 1.0),
        Color.fromRGBO(245, 161, 81, 1.0),
      ],
    ),
    ColorChoice(
      primary: Color(0xFF5A89E6),
      gradient: [
        Color.fromRGBO(77, 85, 225, 1.0),
        Color.fromRGBO(93, 167, 231, 1.0),
      ],
    ),
    ColorChoice(
      primary: Color(0xFF4EC5AC),
      gradient: [
        Color.fromRGBO(61, 188, 156, 1.0),
        Color.fromRGBO(61, 212, 132, 1.0),
      ],
    ),
  ];
}