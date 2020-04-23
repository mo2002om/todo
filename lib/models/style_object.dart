
import 'package:sqflite/sqflite.dart';
import 'package:todo/utils/build_theme_data.dart';
import 'package:todo/utils/utils_string.dart';

import 'helpers/base_element.dart';
import 'menu_object.dart';

class StyleObject extends FireBaseElement {
  static final String nameCollection = "styles";
  int iconId;
  String colorStr;
  String gradColor1;
  String gradColor2;
  StyleObject({
    this.iconId,
    this.colorStr,
    this.gradColor1,
    this.gradColor2,
    id}) : super(id, nameCollection);

  @override
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      "iconId": this.iconId ?? 0,
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
      iconId: 0,
      colorStr: "",
      gradColor1: "",
      gradColor2: "",
    );
    return styleObject;
  }

  @override
  void createTable(Database db) {
    db.rawUpdate("CREATE TABLE $nameCollection ("
        "id varchar(30) primary key,"
        "iconId integer ,"
        "colorStr varchar(30) ,"
        "gradColorOne varchar(30) ,"
        "gradColorTow varchar(30)"
        ")");
  }

  factory StyleObject.sqlFromMap(Map<String, dynamic> map){
    StyleObject styleObject = StyleObject(
      id: map["id"],
      iconId: map["iconId"],
      colorStr: map["colorStr"],
      gradColor1: map["gradColorOne"],
      gradColor2: map["gradColorTow"],
    );
    return styleObject;
  }

  @override
  List<String> columns() {
    return ["id","iconId","colorStr","gradColorOne","gradColorTow"];
  }

  ThemeMenu get getTheme => getThemeMenu(this);
}

ThemeMenu getThemeMenu(StyleObject styleObject){
  return ThemeMenu(
      iconId: styleObject.iconId,
      color: hexToColor(styleObject.colorStr),
      gradient: [
        hexToColor(styleObject.gradColor1),
        hexToColor(styleObject.gradColor2),
      ],
  );
}