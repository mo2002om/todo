

import 'package:sqflite/sqflite.dart';

abstract class FireBaseElement{
  String id;
  final String collectionName;
  FireBaseElement(this.id, this.collectionName);
  Map<String, dynamic> toMap();
  void createTable(Database db);
  List<String> columns ();

}