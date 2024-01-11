import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/models/model_todo_item.dart';

const String tableTodo = 'todos';

const String columnId = 'id';
const String columnDone = 'done';
const String columnTitle = 'title';
const String columnCreatedAt = 'createdAt';
const String columnDescrition = 'description';

class TodoDatabase {
  static Future<Database> initDB() async {
    final database = await openDatabase(
      join(await getDatabasesPath(), 'todos_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE $tableTodo($columnId INTEGER PRIMARY KEY, $columnTitle TEXT, $columnDone BOOLEAN, $columnDescrition TEXT, $columnCreatedAt DATETIME)',
        );
      },
      version: 1,
    );

    return database;
  }

  static Future<List<ModelTodoItem>> list() async {
    final db = await initDB();
    final queryResult = await db.query(
      tableTodo,
      columns: [columnId, columnCreatedAt, columnDescrition, columnDone, columnTitle],
      orderBy: columnCreatedAt, 
    );
    print(queryResult);
    final result = queryResult.map((element) => 
      ModelTodoItem(
        id: element[columnId] as int,
        done: element[columnDone] == 1,
        title: element[columnTitle] as String,
        createdAt: element[columnCreatedAt] as String,
        description: element[columnDescrition] as String,
      )
    ).toList();

    return result;
  }

  static Future<ModelTodoItem> insert(ModelTodoItem item) async {
    final db = await initDB();
    item.id = await db.insert(tableTodo, item.toMap());

    return item;
  }

  static Future<int> delete(int id) async {
    final db = await initDB();
    return await db.delete(tableTodo, where: '$columnId = ?', whereArgs: [id]);
  }

  static Future<int> update(ModelTodoItem todo) async {
    final db = await initDB();
    return await db.update(
      tableTodo,
      todo.toMap(),
      where: '$columnId = ?',
      whereArgs: [todo.id]
    );
  }
}