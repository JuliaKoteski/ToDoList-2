import 'package:bloco_de_notas/service_locator.dart';
import 'package:bloco_de_notas/storage_service.dart';

import 'todo.dart';
import 'package:bloco_de_notas/Todo_filter.dart';
import 'package:flutter/material.dart';

class TodoListNotifier extends ValueNotifier<List<Todo>> {
  TodoListNotifier() : super([]);

  final _allTodosNotifier = ValueNotifier<List<Todo>>([]);
  TodoFilter _currentFilter = TodoFilter.all;
  final _storageService = getIt<StorageService>();

  List<Todo> get _todos => _allTodosNotifier.value;

  Future<void> init() async {
      _allTodosNotifier.value = await _storageService.getTodos();
      _updateToTodoList();
      _allTodosNotifier.addListener(() {
      _updateToTodoList();
      _saveTodoListToDB();
    });
  }

  void add(Todo todo) {
    _allTodosNotifier.value = [..._todos, todo];
  }

  //PARA RENOMEAR TAREFAS
  void update(String id, String task) {
    _allTodosNotifier.value = [
      for (final todo in _todos)
        if (todo.id != id) todo else todo.copyWith(task: task)
    ];
  }

  //PARA MARCAR CHECKBOX
  void toggle(String id) {
    _allTodosNotifier.value = [
      for (final todo in _todos)
        if (todo.id != id) todo else todo.copyWith(completed: !todo.completed)
    ];
  }

  //PARA REMOVER TAREFAS
  void remove(String id) {
    _allTodosNotifier.value = _todos.where((todo) => todo.id != id).toList();
  }

  //PARA REORGANIZAR AS TAREFAS
  void reorder(List<Todo> todos) {
    _allTodosNotifier.value = todos;
  }

  void changeFilter(TodoFilter filter) {
    _currentFilter = filter;
    _updateToTodoList();
  }

  void _updateToTodoList() {
    value = _mapFilterToTodoList();
  }

  void _saveTodoListToDB() {
    var todo;
    _storageService.saveTodos(_todos.where((element) => todo.task.isNotEmpty).toList());
  }

  List<Todo> _mapFilterToTodoList() => switch (_currentFilter) {
        TodoFilter.pendentes =>
          _todos.where((todo) => !todo.completed).toList(),
        TodoFilter.concluidas =>
          _todos.where((todo) => todo.completed).toList(),
        _ => _todos
      };
}

