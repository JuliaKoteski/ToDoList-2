import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bloco_de_notas/todo.dart';

class ApiService {
  final String baseUrl;

  ApiService(this.baseUrl);

  Future<List<Todo>> fetchTodos() async {
    final response = await http.get(Uri.parse('$baseUrl/todos'));

    if (response.statusCode == 200) {
      final List<dynamic> json = jsonDecode(response.body);
      return json.map((e) => Todo.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load todos');
    }
  }

  Future<void> addTodo(Todo todo) async {
    final response = await http.post(
      Uri.parse('$baseUrl/todos'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(todo.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add todo');
    }
  }

  Future<void> updateTodo(Todo todo) async {
    final response = await http.put(
      Uri.parse('$baseUrl/todos/${todo.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(todo.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update todo');
    }
  }

  Future<void> deleteTodo(String id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/todos/$id'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete todo');
    }
  }
}
