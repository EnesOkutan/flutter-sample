import 'package:hello_world/data/model/todo.dart';
import 'package:hello_world/data/service/database_factory.dart';
import 'package:hello_world/util/result.dart';
import 'package:sqflite/sql.dart';

class TodoService {

  late final DatabaseFactory db;

  TodoService() {
    db = DatabaseFactory();
  }

  Future<Result<List<Todo>>> getAll() async {
    try {

      if (!db.isOpen()) {
        await db.open();
      }

      final List<Map<String, Object?>> todoMaps = await db.get().query('todo_list');
      List<Todo> todoList = [];
      for (final map in todoMaps) {
        todoList.add(Todo(id: map['id'] as int, title: map['title'] as String, isDone: map['isDone'] as int == 1 ? true : false));
      }
      return Result(isSuccess: true, value: todoList);
    } on Exception catch(e) {
      return Result(isSuccess: false, error: e);
    }
  }

  Future<Result> delete(int id) async {
    try {

      if (!db.isOpen()) {
        await db.open();
      }

      await db.get().delete('todo_list', where: 'id = ?', whereArgs: [id]);
      return Result(isSuccess: true);
    } on Exception catch(e) {
      return Result(isSuccess: false, error: e);
    }
  }

  Future<Result<int>> insert(Todo todo) async {
    try {

      if (!db.isOpen()) {
        await db.open();
      }

      final id = await db.get().insert('todo_list', todo.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
      return Result(isSuccess: true, value: id);
    } on Exception catch(e) {
      return Result(isSuccess: false, error: e);
    }
  }

  Future<Result<int>> update(Todo todo) async {
    try {

      if (!db.isOpen()) {
        await db.open();
      }

      final id = await db.get().update('todo_list', todo.toMap(), where: 'id = ?', whereArgs: [todo.id]);
      return Result(isSuccess: true, value: id);
    } on Exception catch(e) {
      return Result(isSuccess: false, error: e);
    }
  }

}