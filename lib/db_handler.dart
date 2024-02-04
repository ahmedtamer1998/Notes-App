import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:note_app/model/model.dart';

class DBHelper {
  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDatabase();
    return null;
  }

  initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'Todo.db');
    var db = await openDatabase(path, version: 1, onCreate: _createDatabase);
    return db;
  }

  // creating table in the database
  _createDatabase(Database db, int version) async {
    await db.execute(
      "CREATE TABLE my_note_table(id INTEGER PRIMARY KEY AUTOINCREMENT ,title TEXT NOT NULL, desc TEXT NOT NULL ,dateAndTime TEXT NOT NULL, isDone INTEGER DEFAULT 0)",
    );
  }

  //inserting data
  Future<TodoModel> insert(TodoModel todoModel) async {
    var dbClient = await db;
    await dbClient?.insert('my_note_table', todoModel.toMap());
    return todoModel;
  }

  //getting data
  Future<List<TodoModel>> getDataList() async {
    await db;
    final List<Map<String, Object?>> QueryResult =
        await _db!.rawQuery('Select * FROM my_note_table');
    return QueryResult.map((e) => TodoModel.fromMap(e)).toList();
  }

  //deleting data
  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient!.delete('my_note_table', where: 'id = ?', whereArgs: [id]);
  }

  //updating data
  Future<int> update(TodoModel todoModel) async {
    var dbClient = await db;
    return await dbClient!.update('my_note_table', todoModel.toMap(),
        where: 'id = ?', whereArgs: [todoModel.id]);
  }
}
