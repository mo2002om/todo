
import 'package:sqflite/sqflite.dart';
import 'package:todo/utils/utils_string.dart';

import 'helpers/base_element.dart';

class TaskObject extends FireBaseElement {
  static final String nameCollection = "tasks";
  String menuId;
  String dayId;
  String title;
  int done;
  int timestamp;
  int startDate;


  TaskObject({
    this.menuId,
    this.dayId,
    this.title,
    this.done,
    this.startDate,

    this.timestamp,
    id}) : super(id, nameCollection);

  @override
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      "menuId": this.menuId,
      "dayId": this.dayId,
      "title": this.title,
      "done": this.done ?? 0,
      "startDate": this.startDate ?? new DateTime.now().millisecondsSinceEpoch,
      "timestamp": this.timestamp ?? new DateTime.now().millisecondsSinceEpoch,
    };
    if (this.id != null) {
      map["id"] = id;
    }else{
      map["id"] = createId();
    }
    return map;
  }
  static TaskObject getTaskObject() {
    TaskObject taskObject = new TaskObject(
      menuId: "",
      title: "",
      done: 0,
      startDate: new DateTime.now().millisecondsSinceEpoch,
      timestamp: new DateTime.now().millisecondsSinceEpoch,
    );
    return taskObject;
  }

  @override
  void createTable(Database db) {
    db.rawUpdate("CREATE TABLE $nameCollection ("
        "id varchar(30) primary key,"
        "menuId varchar(30) ,"
        "dayId varchar(30) ,"
        "title varchar(30) ,"
        "done integer ,"
        "startDate integer ,"
        "timestamp integer"
        ")");
  }

  factory TaskObject.sqlFromMap(Map<String, dynamic> map){
    TaskObject taskObject = TaskObject(
      id: map["id"],
      menuId: map["menuId"],
      dayId: map["dayId"],
      title: map["title"],
      done: map["done"],
      startDate: map["startDate"],
      timestamp: map["timestamp"],
    );
    return taskObject;
  }

  @override
  List<String> columns() {
    return ["id","menuId","dayId","title","done","startDate","timestamp"];
  }

  bool get isCompleted => done == 1 ? true : false;
  int get pushId => getPushId(timestamp: startDate);


}