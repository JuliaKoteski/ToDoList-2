 import 'package:bloco_de_notas/todo.dart';
 
 abstract class StorageService {
  Future<List<Todo>> getTodos();
  Future<void> saveTodos(List<Todo> todos);
 }


