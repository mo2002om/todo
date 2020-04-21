
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/utils/utils_string.dart';

import 'helpers/base_element.dart';
import 'task_object.dart';

class MenuObject extends FireBaseElement {
  static final String nameCollection = "menus";
  int timestamp;
  String name;
  int themeMenuId;
  List<TaskObject> tasks = [];
  MenuObject({
    this.name,
    this.timestamp,
    this.themeMenuId,
    id}) : super(id, nameCollection);

  @override
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      "name": this.name,
      "themeMenuId": this.themeMenuId ?? 0,
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
      themeMenuId: 0,
      timestamp: new DateTime.now().millisecondsSinceEpoch,
    );
    return menuObject;
  }

  @override
  void createTable(Database db) {
    db.rawUpdate("CREATE TABLE $nameCollection ("
        "id varchar(30) primary key,"
        "name varchar(30) ,"
        "themeMenuId integer ,"
        "timestamp integer"
        ")");
  }

  factory MenuObject.sqlFromMap(Map<String, dynamic> map){
    MenuObject menuObject = MenuObject(
      id: map["id"],
      name: map["name"],
      themeMenuId: map["themeMenuId"],
      timestamp: map["timestamp"],
    );
    return menuObject;
  }

  @override
  List<String> columns() {
    return ["id","name","themeMenuId","timestamp"];
  }

  ThemeMenu get themeMenu => ListThemeMenu.choices[themeMenuId];
  LinearGradient get gradient => LinearGradient(colors: themeMenu.gradient, begin: Alignment.bottomCenter, end: Alignment.topCenter);

  double percentComplete() {
    if (tasks.isEmpty) {
      return 1.0;
    }
    int completed = 0;
    for(TaskObject taskObject in tasks){
      if(taskObject.done == 1){
        completed += 1;
      }
    }
    return completed / tasks.length;
  }

}

List<MenuObject> listMenus = [
  new MenuObject(id: "111",name: "veryImportant" ,themeMenuId: 0,timestamp: new DateTime.now().millisecondsSinceEpoch),
  new MenuObject(id: "222",name: "personal" ,themeMenuId: 1,timestamp: new DateTime.now().millisecondsSinceEpoch),
  new MenuObject(id: "333",name: "work" ,themeMenuId: 2,timestamp: new DateTime.now().millisecondsSinceEpoch),
  new MenuObject(id: "444",name: "home" ,themeMenuId: 3,timestamp: new DateTime.now().millisecondsSinceEpoch),
  new MenuObject(id: "555",name: "shopping" ,themeMenuId: 4,timestamp: new DateTime.now().millisecondsSinceEpoch),
  new MenuObject(id: "666",name: "training" ,themeMenuId: 5,timestamp: new DateTime.now().millisecondsSinceEpoch),
];



class ThemeMenu {
  ThemeMenu({@required this.icon,@required this.color, @required this.gradient});
  final IconData icon;
  final Color color;
  final List<Color> gradient;
}

class ListThemeMenu {
  static List<ThemeMenu> choices = [
    ThemeMenu(
      icon: Icons.alarm,
      color: Color(0xFFF77B67),
      gradient: [
        Color(0xFFF54471),
        Color(0xFFF5a151),
      ],
    ),
    ThemeMenu(
      icon: Icons.person,
      color: Color(0xFF5A89E6),
      gradient: [
        Color(0xFF4d55e1),
        Color(0xFF5da7e7),
      ],
    ),
    ThemeMenu(
      icon: Icons.work,
      color: Color(0xFF9f6565),
      gradient: [
        Color(0xFF9f6582),
        Color(0xFF9f8265),
      ],
    ),
    ThemeMenu(
      icon: Icons.home,
      color: Color(0xFF9319f2),
      gradient: [
        Color(0xFF2619f2),
        Color(0xFFf219e5),
      ],
    ),
    ThemeMenu(
      icon: Icons.shopping_basket,
      color: Color(0xFFdd73a8),
      gradient: [
        Color(0xFFdd7373),
        Color(0xFFdda873),
      ],
    ),
    ThemeMenu(
      icon: Icons.school,
      color: Color(0xFF4EC5AC),
      gradient: [
        Color(0xFF3dbc9c),
        Color(0xFF3dd484),
      ],
    ),
  ];
}
