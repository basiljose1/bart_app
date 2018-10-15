import 'dart:async';
import 'dart:io' as io;

import 'package:path/path.dart';
import 'package:bart_app/models/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  static Database _db;

  Future<Database> get db async {
    if(_db != null)
      return _db;
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "main.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }


  void _onCreate(Database db, int version) async {
    // When creating the db, create the table
    await db.execute(
        "CREATE TABLE Token(id INTEGER PRIMARY KEY, token TEXT)");
    print("Created tables");
  }

  Future<int> saveToken(String token) async {
    var dbClient = await db;
    int res = await dbClient.insert("Token", {"token": token});
    return res;
  }

  Future<int> deleteToken() async {
    var dbClient = await db;
    int res = await dbClient.delete("Token");
    return res;
  }

  Future<String> getToken() async {
    var dbClient = await db;
    var res = await dbClient.query("Token");
    print(res.toString());
    return res.toString();
  }

  Future<bool> isLoggedIn() async {
    var dbClient = await db;
    var res = await dbClient.query("Token");
    return res.length > 0? true: false;
  }

}
