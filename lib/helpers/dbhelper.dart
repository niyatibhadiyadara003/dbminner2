import 'dart:convert';
import 'dart:typed_data';

import 'package:dbmanner/model/animalmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Dbhelper {
  Dbhelper._();

  static final Dbhelper dbhelper = Dbhelper._();
  Database? db;

  String dbname = "flutterdbmanner.db";
  String tablename = "mammals";
  String colid = "id";
  String colimage = "image";
  String colname = "name";
  String coldes = "description";

  String tablebirdname = 'tablebird';

  String tablefishname = 'tablebird';

  Future<Database?> initdb() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, dbname);

    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      String query =
          "CREATE TABLE IF NOT EXISTS $tablename($colid TEXT PRIMARY KEY,$colname TEXT,$colimage TEXT,$coldes TEXT);";
      String query1 =
          "CREATE TABLE IF NOT EXISTS $tablebirdname($colid TEXT PRIMARY KEY,$colname TEXT,$colimage TEXT,$coldes TEXT);";
      String query2 =
          "CREATE TABLE IF NOT EXISTS $tablefishname($colid TEXT PRIMARY KEY,$colname TEXT,$colimage TEXT,$coldes TEXT);";

      await db.execute(query);

      await db.execute(query1);

      await db.execute(query2);
    });
    return db;
  }

//================================================================
  Future<int> insertdb(
      {required String id,
      required String name,
      required String image,
      required String description}) async {
    db = await initdb();

    String query =
        "INSERT INTO $tablename($colid,$colname,$colimage,$coldes)VALUES(?,?,?,?)";

    List args = [id, name, image, description];
    return await db!.rawInsert(query, args);
  }

  Future<List<Mammalmodel>> fetch() async {
    db = await initdb();

    String query = "SELECT * FROM $tablename";

    List<Map<String, dynamic>> data = await db!.rawQuery(query);
    List<Mammalmodel> alldata =
        data.map((e) => Mammalmodel.frommap(e)).toList();

    return alldata;
  }

  delete() async {
    db = await initdb();
    String query = "DELETE FROM $tablename";
    await db!.rawDelete(query);
  }

  //----------------------------------------------------------------------

//================================================================
  Future<int> insertbirddb(
      {required String id,
      required String name,
      required String image,
      required String description}) async {
    db = await initdb();

    String query =
        "INSERT INTO $tablebirdname($colid,$colname,$colimage,$coldes)VALUES(?,?,?,?)";

    List args = [id, name, image, description];
    return await db!.rawInsert(query, args);
  }

  Future<List<Mammalmodel>> fetchbird() async {
    db = await initdb();

    String query = "SELECT * FROM $tablebirdname";

    List<Map<String, dynamic>> data = await db!.rawQuery(query);
    List<Mammalmodel> alldata =
        data.map((e) => Mammalmodel.frommap(e)).toList();

    return alldata;
  }

  deletebird() async {
    db = await initdb();
    String query = "DELETE FROM $tablebirdname";
    await db!.rawDelete(query);
  }

//----------------------------------------------------------------------

//================================================================
  Future<int> insertfishdb(
      {required String id,
      required String name,
      required String image,
      required String description}) async {
    db = await initdb();

    String query =
        "INSERT INTO $tablefishname($colid,$colname,$colimage,$coldes)VALUES(?,?,?,?)";

    List args = [id, name, image, description];
    return await db!.rawInsert(query, args);
  }

  Future<List<Mammalmodel>> fetchfish() async {
    db = await initdb();

    String query = "SELECT * FROM $tablefishname";

    List<Map<String, dynamic>> data = await db!.rawQuery(query);
    List<Mammalmodel> alldata =
        data.map((e) => Mammalmodel.frommap(e)).toList();

    return alldata;
  }

  deletefish() async {
    db = await initdb();
    String query = "DELETE FROM $tablefishname";
    await db!.rawDelete(query);
  }

//----------------------------------------------------------------------
}
