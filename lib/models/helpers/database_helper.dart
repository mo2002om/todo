import 'dart:io';
import 'dart:typed_data';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/utils/utils_files.dart';

import '../menu_object.dart';
import '../task_object.dart';
import '../tools.dart';
import 'base_element.dart';


final String dataFileName = "database.db";
class DatabaseHelper {
  ///Database
  static final DatabaseHelper _instance = new DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();
  Database _database;
  Future<Database> get db async {
    if (_database != null) {
      return _database;
    }
    _database = await open();
    return _database;
  }
  Future<Database> open() async {
    try{
      Directory dic = await getLocalPath;
      String path = dic.path + "/$dataFileName";

      print(path);
      var db  = await openDatabase(path,
          version: 1,
          onCreate: (Database database, int version) {
            new Tools().createTable(database);
            new MenuObject().createTable(database);
            new TaskObject().createTable(database);
          });
      return db;
    }catch(e){
      print(e.toString());
    }
    return null;
  }
  Future closeDb()async{
    var dbClient = await db ;
    _database = null;
    dbClient.close();
  }


  ///TableElement
  Future<FireBaseElement> insert(FireBaseElement element) async {
    var dbClient = await db;
    Map<String, dynamic> map = element.toMap();
    await dbClient.insert(element.collectionName, map);
    element.id = map["id"];
    return element;
  }
  Future<int> delete(FireBaseElement element) async {
    var dbClient = await db;
    return await dbClient.delete(element.collectionName, where: 'id = ?', whereArgs: [element.id]);
  }
  Future<bool> infoElement({FireBaseElement element}) async {
    Database dbClient = await db;
    List<Map> maps = await dbClient.query(element.collectionName,where: 'id = ?', whereArgs: [element.id], columns: element.columns());
    if(maps.length > 0){
      return true;
    }
    return false;
  }
  Future<int> update(FireBaseElement element) async {
    var dbClient = await db;
    return await dbClient.update(element.collectionName, element.toMap(),
        where: 'id = ?', whereArgs: [element.id]);
  }

  Future<Tools> getTools() async{
    Database dbClient = await db;
    List<Map> maps = await dbClient.query(Tools.nameCollection,where: 'id = ?', whereArgs: ["111"], columns: Tools().columns(),orderBy: "id desc");
    if(maps.length > 0){
      Tools tools = new Tools.sqlFromMap(maps[0]);
      return tools;
    }
    return null;
  }

  Future<List<TaskObject>> getListTaskObjectWitMenuId({@required String menuId, @required String dayId}) async{
    List<TaskObject> list = [];
    Database dbClient = await db;
    List<Map> maps = await dbClient.query(TaskObject.nameCollection,where: 'menuId = ? AND dayId = ?', whereArgs: [menuId,dayId], columns: TaskObject().columns(),orderBy: "timestamp desc");
    for(Map map in maps){
      TaskObject taskObject = new TaskObject.sqlFromMap(map);
      list.add(taskObject);
    }
    return list;
  }

}
