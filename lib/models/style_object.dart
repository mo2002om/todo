
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/utils/build_theme_data.dart';
import 'package:todo/utils/utils_string.dart';

import 'helpers/base_element.dart';
import 'menu_object.dart';

class StyleObject extends FireBaseElement {
  static final String nameCollection = "styles";
  String colorStr;
  String gradColor1;
  String gradColor2;
  bool isUsed = true;
  StyleObject({
    this.colorStr,
    this.gradColor1,
    this.gradColor2,
    id}) : super(id, nameCollection);

  @override
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      "colorStr": this.colorStr,
      "gradColorOne": this.gradColor1,
      "gradColorTow": this.gradColor2,
    };
    if (this.id != null) {
      map["id"] = id;
    }else{
      map["id"] = createId();
    }
    return map;
  }
  static StyleObject getStyleObject() {
    StyleObject styleObject = new StyleObject(
      colorStr: "",
      gradColor1: "",
      gradColor2: "",
    );
    return styleObject;
  }
  static List<StyleObject> listStanderStyles() {
    return [
      new StyleObject(id: "0",colorStr: Color(0xFFF77B67).toHex() ,gradColor1: Color(0xFFF5a151).toHex(),gradColor2: Color(0xFFF54471).toHex()),
      new StyleObject(id: "1",colorStr: Color(0xFF5A89E6).toHex() ,gradColor1: Color(0xFF5da7e7).toHex(),gradColor2: Color(0xFF4d55e1).toHex()),
      new StyleObject(id: "2",colorStr: Color(0xFF9f6565).toHex() ,gradColor1: Color(0xFF9f8265).toHex(),gradColor2: Color(0xFF9f6582).toHex()),
      new StyleObject(id: "3",colorStr: Color(0xFF9319f2).toHex() ,gradColor1: Color(0xFFf219e5).toHex(),gradColor2: Color(0xFF2619f2).toHex()),
      new StyleObject(id: "4",colorStr: Color(0xFFdd73a8).toHex() ,gradColor1: Color(0xFFdda873).toHex(),gradColor2: Color(0xFFdd7373).toHex()),
      new StyleObject(id: "5",colorStr: Color(0xFF4EC5AC).toHex() ,gradColor1: Color(0xFF3dd484).toHex(),gradColor2: Color(0xFF3dbc9c).toHex()),
    ];
  }

  @override
  void createTable(Database db) {
    db.rawUpdate("CREATE TABLE $nameCollection ("
        "id varchar(30) primary key,"
        "colorStr varchar(30) ,"
        "gradColorOne varchar(30) ,"
        "gradColorTow varchar(30)"
        ")");
  }

  factory StyleObject.sqlFromMap(Map<String, dynamic> map){
    StyleObject styleObject = StyleObject(
      id: map["id"],
      colorStr: map["colorStr"],
      gradColor1: map["gradColorOne"],
      gradColor2: map["gradColorTow"],
    );
    return styleObject;
  }


  @override
  List<String> columns() {
    return ["id","colorStr","gradColorOne","gradColorTow"];
  }

  List<Color> get colors => [
    hexToColor(gradColor1),
    hexToColor(gradColor2)
  ];

  LinearGradient get getLinear => LinearGradient(
      colors: colors,
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
  );

  Color get color => hexToColor(colorStr);
}

//ThemeMenu getThemeMenu(StyleObject styleObject){
//  return ThemeMenu(
//      iconId: styleObject.iconId,
//      color: hexToColor(styleObject.colorStr),
//      gradient: [
//        hexToColor(styleObject.gradColor1),
//        hexToColor(styleObject.gradColor2),
//      ],
//  );
//}