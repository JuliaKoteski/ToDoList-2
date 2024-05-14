import 'dart:convert';

import 'package:bloco_de_notas/storage_service.dart';
import 'package:bloco_de_notas/todo.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveStorage extends StorageService {
  static const todosBoxName = 'todos';

  @override
  Future<List<Todo>> getTodos() async {
    final todosBox = await Hive.openBox<String>(todosBoxName);

    return todosBox.values.map((todo) => Todo.fromJson(jsonDecode(todo))).toList();
  }

  @override
  Future<void> saveTodos(List<Todo> todos) async {
    final todosBox = await Hive.openBox<String>(todosBoxName);
    await todosBox.clear();

    for (final todo in todos) {
      todosBox.add(jsonEncode(todo));
    }
  }
}

