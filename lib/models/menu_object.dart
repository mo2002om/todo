
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/app_localizations.dart';
import 'package:todo/utils/build_theme_data.dart';
import 'package:todo/utils/utils_string.dart';

import 'helpers/base_element.dart';
import 'style_object.dart';
import 'task_object.dart';

class MenuObject extends FireBaseElement {
  static final String nameCollection = "menus";
  int timestamp;
  String name;
  String styleId;
  List<TaskObject> tasks = [];
  StyleObject style;
  int iconId;
  MenuObject({
    this.iconId,
    this.name,
    this.timestamp,
    this.styleId,
    id}) : super(id, nameCollection);

  @override
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      "name": this.name,
      "iconId": this.iconId ?? 0,
      "styleId": this.styleId ?? "0",
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
      iconId: 0,
      styleId: "0",
      timestamp: new DateTime.now().millisecondsSinceEpoch,
    );
    return menuObject;
  }

  @override
  void createTable(Database db) {
    db.rawUpdate("CREATE TABLE $nameCollection ("
        "id varchar(30) primary key,"
        "name varchar(30) ,"
        "iconId integer ,"
        "styleId varchar(30) ,"
        "timestamp integer"
        ")");
  }

  factory MenuObject.sqlFromMap(Map<String, dynamic> map){
    MenuObject menuObject = MenuObject(
      id: map["id"],
      name: map["name"],
      iconId: map["iconId"],
      styleId: map["styleId"],
      timestamp: map["timestamp"],
    );
    return menuObject;
  }

  @override
  List<String> columns() {
    return ["id","name","iconId","styleId","timestamp"];
  }


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

  String getTitle(BuildContext context){
    switch(name){
      case "veryImportant":
        return getTranslated(context, name);
        break;
      case "personal":
        return getTranslated(context, name);
        break;
      case "work":
        return getTranslated(context, name);
        break;
      case "home":
        return getTranslated(context, name);
        break;
      case "shopping":
        return getTranslated(context, name);
        break;
      case "training":
        return getTranslated(context, name);
        break;
      default:
        return name;
    }
  }

  static List<MenuObject> listStanderMenus() {
    List<MenuObject> list = [];
    for(int i = 0; i < 6 ; i++){
      MenuObject menuObject = new MenuObject(
          id: i.toString(),
          name: listKeysTranslated[i],
          iconId: i,
          styleId: i.toString(),
          timestamp: new DateTime.now().millisecondsSinceEpoch,
      );
      menuObject.style = StyleObject.listStanderStyles()[i];
      list.add(menuObject);
    }
    return list;
  }
  IconData get icon => appListIcon[iconId];
  int get getCompletedValue => getValue(ofTasks: tasks,value: 1);
  int get getIncompleteValue => getValue(ofTasks: tasks,value: 0);

}
int getValue({List<TaskObject> ofTasks,int value}){
  if(ofTasks.length == 0) return 0;
  List<TaskObject> list = [];
  for(TaskObject task in ofTasks){
    if(task.isCompleted){
      list.add(task);
    }
  }
  return ((list.length / ofTasks.length) * 100).toInt();
}

//List<MenuObject> listMenus = [
//  new MenuObject(id: "111",name: "veryImportant" ,styleId: 0,timestamp: new DateTime.now().millisecondsSinceEpoch),
//  new MenuObject(id: "222",name: "personal" ,styleId: 1,timestamp: new DateTime.now().millisecondsSinceEpoch),
//  new MenuObject(id: "333",name: "work" ,styleId: 2,timestamp: new DateTime.now().millisecondsSinceEpoch),
//  new MenuObject(id: "444",name: "home" ,styleId: 3,timestamp: new DateTime.now().millisecondsSinceEpoch),
//  new MenuObject(id: "555",name: "shopping" ,styleId: 4,timestamp: new DateTime.now().millisecondsSinceEpoch),
//  new MenuObject(id: "666",name: "training" ,styleId: 5,timestamp: new DateTime.now().millisecondsSinceEpoch),
//];

List<String> listKeysTranslated = [
  "veryImportant",
  "personal",
  "work",
  "home",
  "shopping",
  "training"
];



//class ThemeMenu {
//  ThemeMenu({@required this.iconId,@required this.color, @required this.gradient});
//  final int iconId;
//  final Color color;
//  final List<Color> gradient;
//
//  String get getStyleId => iconId.toString();
//
//  String get getColorStr =>  colorToHex(color);
//  String get getGradColor1 => colorToHex(gradient[0]);
//  String get getGradColor2 => colorToHex(gradient[1]);
//
//  IconData get icon => appListIcon[iconId];
//  LinearGradient get getLinear => LinearGradient(colors: gradient, begin: Alignment.topCenter, end: Alignment.bottomCenter);
//
//
//}
//
//class ListThemeMenu {
//  static List<ThemeMenu> choices = [
//    ThemeMenu(
//      iconId:0,
//      color: Color(0xFFF77B67),
//      gradient: [
//        Color(0xFFF5a151),
//        Color(0xFFF54471),
//
//      ],
//    ),
//    ThemeMenu(
//      iconId:1,
//      color: Color(0xFF5A89E6),
//      gradient: [
//        Color(0xFF5da7e7),
//        Color(0xFF4d55e1),
//      ],
//    ),
//    ThemeMenu(
//      iconId:2,
//      color: Color(0xFF9f6565),
//      gradient: [
//        Color(0xFF9f8265),
//        Color(0xFF9f6582),
//      ],
//    ),
//    ThemeMenu(
//      iconId:3,
//      color: Color(0xFF9319f2),
//      gradient: [
//        Color(0xFFf219e5),
//        Color(0xFF2619f2),
//      ],
//    ),
//    ThemeMenu(
//      iconId:4,
//      color: Color(0xFFdd73a8),
//      gradient: [
//        Color(0xFFdda873),
//        Color(0xFFdd7373),
//      ],
//    ),
//    ThemeMenu(
//      iconId:5,
//      color: Color(0xFF4EC5AC),
//      gradient: [
//        Color(0xFF3dd484),
//        Color(0xFF3dbc9c),
//      ],
//    ),
//  ];
//}

List<IconData> appListIcon = [
  Icons.alarm,
  Icons.person,
  Icons.work,
  Icons.home,
  Icons.shopping_basket,
  Icons.school,
  Icons.accessibility,
  Icons.account_balance_wallet,
  Icons.airplanemode_active,
  Icons.airplay,
  Icons.airport_shuttle,
  Icons.alternate_email,
  Icons.beach_access,
  Icons.bookmark,
  Icons.branding_watermark,
  Icons.brightness_3,
  Icons.broken_image,
  Icons.build,
  Icons.business,
  Icons.cake,
  Icons.call,
  Icons.directions_bike,
  Icons.directions_run,
  Icons.event_seat,
  Icons.favorite,
  Icons.filter_frames,
  Icons.free_breakfast,




];


