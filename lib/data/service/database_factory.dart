import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseFactory {

  Database? _instance;

  Future<void> open() async {
    
    WidgetsFlutterBinding.ensureInitialized();
    
    _instance = await openDatabase(
      join(await getDatabasesPath(), "hello_world.db"),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE IF NOT EXISTS todo_list(id INTEGER PRIMARY KEY, title TEXT, isDone INTEGER)',
        );
      },
      version: 1,
    );
  }

  bool isOpen() {
    return _instance != null && _instance!.isOpen;
  }

  Database get() {
    return _instance!;
  }

}