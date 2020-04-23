
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/utils/language.dart';

import 'helpers/base_element.dart';
import 'helpers/database_helper.dart';

class Tools extends FireBaseElement {
  static final String nameCollection = "tools";
  int languageId;
  String languageFlag;
  String languageName;
  String languageCode;
  int timestamp;
  int calendarId; // 0 M || 1 hijri


  Tools({
    this.timestamp,
     this.languageId,
     this.languageFlag,
     this.languageName,
     this.languageCode,
    this.calendarId,
    id})
      : super(id, nameCollection);


  @override
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      "languageId": this.languageId ?? Language.languageList().first.id,
      "languageFlag": this.languageFlag ?? Language.languageList().first.flag,
      "languageCode": this.languageCode ?? Language.languageList().first.languageCode,
      "languageName": this.languageName ?? Language.languageList().first.name,
      "timestamp": this.timestamp ?? new DateTime.now().millisecondsSinceEpoch,
      "calendarId": this.calendarId ?? 0,
    };
    if (this.id != null) {
      map["id"] = id;
    }else{
      map["id"] = "111";
    }
    return map;
  }
  static Tools getTools() {
    Tools tools = new Tools(
      id: "111",
      languageId: Language.languageList().first.id,
      languageFlag: Language.languageList().first.flag,
      languageCode: Language.languageList().first.languageCode,
      languageName: Language.languageList().first.name,
      timestamp: new DateTime.now().millisecondsSinceEpoch,
      calendarId: 0,

    );
    return tools;
  }

  @override
  void createTable(Database db) {
    db.rawUpdate("CREATE TABLE $nameCollection ("
        "id varchar(30) primary key,"
        "languageId integer,"
        "languageFlag varchar(30),"
        "languageCode varchar(30),"
        "languageName varchar(30),"
        "calendarId integer,"
        "timestamp integer"
        ")");
  }

  factory Tools.sqlFromMap(Map<String, dynamic> map){
    Tools tools = Tools(
      id: map["id"],
      languageId: map["languageId"],
      languageFlag: map["languageFlag"],
      languageCode: map["languageCode"],
      languageName: map["languageName"],
      timestamp: map["timestamp"],
      calendarId: map["calendarId"],
    );
    return tools;
  }

  @override
  List<String> columns() {
    return ["id","languageId","languageFlag","languageCode","languageName","timestamp","calendarId"];
  }
  Locale get selectedLocale => Language.getLocale(lang: Language(id: languageId,name: languageName,flag: languageFlag,languageCode: languageCode));

}

class Bloc {
  // ignore: close_sinks
  final themeController = StreamController<Tools>();
  get streamTools => themeController.stream;
  Bloc(){
    setTools();
  }
  void update({Tools tools}) async {
    await DatabaseHelper().update(tools);
    setTools();
  }

  void setTools() async {
    Tools tools = await DatabaseHelper().getTools();
    if(tools == null){
      await DatabaseHelper().insert(Tools.getTools());
      setTools();
    }else{
      themeController.sink.add(tools);
    }
  }
}

final bloc = Bloc();