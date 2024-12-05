import 'package:hello_world/data/model/todo.dart';

import 'package:hello_world/data/service/todo_service.dart';
import 'package:hello_world/util/result.dart';

class TodoRepository {
  TodoRepository({
    required TodoService todoService,
  }) : _todoService = todoService;

  final TodoService _todoService;

  Future<Result<List<Todo>>> getAll() async {
    return _todoService.getAll();
  }

  Future<Result<int>> create(Todo todo) async {
    return _todoService.insert(todo);
  }
  
  Future<Result<int>> update(todo) async {
    return _todoService.update(todo);
  }

  Future<Result<void>> delete(int id) async {
    return _todoService.delete(id);
  }

}