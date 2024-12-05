import 'package:flutter/material.dart';
import 'package:hello_world/data/model/todo.dart';
import 'package:hello_world/data/repositories/todo_repository.dart';
import 'package:hello_world/util/result.dart';

class TodoListViewModel extends ChangeNotifier {
  TodoListViewModel({
    required TodoRepository todoRepository,
  }) : _todoRepository = todoRepository {
    getAll();
  }

  final TodoRepository _todoRepository;

  List<Todo>? todos = [];

  Future<Result<void>> getAll() async {
    try {
      final result = await _todoRepository.getAll();
      switch (result.isSuccess) {
        case true:
          todos = result.value;
          return Result(isSuccess: true);
        case false:
          return Result(error: result.error);
        default:
          return Result();
      }
    } on Exception catch(e) {
      return Result(error: e);
    } finally {
      notifyListeners();
    }
  }

  Future<Result<Todo>> add(String title) async {
    try {
      Todo todo = Todo(id: 0, title: title, isDone: false);
      final result = await _todoRepository.create(todo);
      todo.id = result.value!;
      switch (result.isSuccess) {
        case true:
          todos?.add(todo);
          return Result(isSuccess: true);
        case false:
          return Result(isSuccess: false);
        default:
          return Result();
      }
    } on Exception catch(e) {
      return Result(error: e);
    } finally {
      notifyListeners();
    }
  }

  Future<Result<void>> update(Todo todo) async {
    try {
      final result = await _todoRepository.update(todo);
      switch (result.isSuccess) {
        case true:
          return Result(isSuccess: true);
        case false:
          return Result(isSuccess: false);
        default:
          return Result();
      }
    } on Exception catch(e) {
      return Result(error: e);
    } finally {
      notifyListeners();
    }
  }

  Future<Result<void>> delete(int id) async {
    try {
      final result = await _todoRepository.delete(id);
      switch (result.isSuccess) {
        case true:
          todos?.removeWhere((todo) => todo.id == id);
          return Result(isSuccess: true);
        case false:
          return Result(isSuccess: false);
        default:
          return Result();
      }
    } on Exception catch(e) {
      return Result(error: e);
    } finally {
      notifyListeners();
    }
  }

}