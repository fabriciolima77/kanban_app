import 'dart:core';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const String taskTable = "taskTable";
const String idColumn = 'idColimn';
const String titleColumn = 'titleColumn';
const String contentColumn = 'contentColumn';

class TaskHelper {

  static final TaskHelper _instance = TaskHelper.internal();

  factory TaskHelper() => _instance;

  TaskHelper.internal();

  Database? _db;

  Future<Database> get db async {
    if(_db != null) {
      return _db!;
    }else{
      _db = await initDb();
      return _db!;
    }
  }

  Future<Database> initDb() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'tasksnew.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int newerVersion) async{
        await db.execute(
          "CREATE TABLE $taskTable($idColumn INTEGER PRIMARY KEY AUTOINCREMENT, $titleColumn TEXT, $contentColumn TEXT)"
        );
      }
    );
  }

  Future<Task> saveTask(Task task) async {
    Database? dbTask = await db;
    task.id = await dbTask.insert(
      taskTable,
      task.toMap()
    );
    return task;
  }

  Future<Task?> getTask(int id) async {
    Database? dbTask = await db;
    List<Map> maps = await dbTask.query(taskTable,
    columns: [idColumn, titleColumn, contentColumn],
      where: '$idColumn = ?',
      whereArgs: [id]);
    if(maps.isNotEmpty){
      return Task.fromMap(maps.first);
    }else{
      return null;//return null
    }
  }

  Future<int> deleteTask(int id) async {
    Database dbTask = await db;
    return await dbTask.delete(
      taskTable,
      where: '$idColumn = ?',
      whereArgs: [id]);
  }

  Future<int> updateTask(Task task) async {
    Database dbTask = await db;
    return await dbTask.update(
    taskTable,
    task.toMap(),
    where: '$idColumn = ?',
    whereArgs: [task.id]);
  }

  Future<List> getAllTasks() async {
    Database dbTask = await db;
    List listMap = await dbTask.rawQuery('SELECT * FROM $taskTable');
    List<Task> listTask = [];
    for(Map m in listMap){
      listTask.add(Task.fromMap(m));
    }
    return listTask;
  }

  Future close() async {
    Database dbContact = await db;
    dbContact.close();
  }
}

class Task {
  int? id;
  String? title;
  String? content;

  Task();

  Task.fromMap(Map map){
    id = map[idColumn];
    title = map[titleColumn];
    content = map[contentColumn];
  }

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = {
      titleColumn: title,
      contentColumn: content,
    };
    if(id != null) {
      map[idColumn] = id;
    }
    return map;
  }

  @override
  String toString(){
    return 'Task(id: $id, title: $title, content: $content)';
  }

}