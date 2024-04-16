import 'package:bloco_de_notas/To_do.dart';
import 'package:bloco_de_notas/Todo_filter.dart';
import 'package:flutter/material.dart';

class TodoListNotifier extends ValueNotifier<List<Todo>> {
  TodoListNotifier() : super(_initialValue);

  static final List<Todo> _initialValue = [
    Todo.create('Inserir Tarefa'),
  ];

  final _todasTodosNotifier = ValueNotifier<List<Todo>>(_initialValue);
  TodoFilter _currentFilter = TodoFilter.todas;

  List<Todo> get _todos => _todasTodosNotifier.value;

  void init() {
    _todasTodosNotifier.addListener(() => _updateToTodoList());
  }

  void add(Todo todo) {
    _todasTodosNotifier.value = [..._todos, todo];
  }

  //PARA RENOMEAR TAREFAS
  void update(String id, String task) {
    _todasTodosNotifier.value = [
      for (final todo in _todos)
        if (todo.id != id) todo else todo.copyWith(task: task)
    ];
  }

  //PARA MARCAR CHECKBOX
  void toggle(String id) {
    _todasTodosNotifier.value = [
      for (final todo in _todos)
        if (todo.id != id) todo else todo.copyWith(completed: !todo.completed)
    ];
  }

  //PARA REMOVER TAREFAS
  void remove(String id) {
    _todasTodosNotifier.value = _todos.where((todo) => todo.id != id).toList();
  }

  //PARA REORGANIZAR AS TAREFAS
  void reorder(List<Todo> todos) {
    _todasTodosNotifier.value = todos;
  }

  void changeFilter(TodoFilter filter) {
    _currentFilter = filter;
    _updateToTodoList();
  }

  void _updateToTodoList() {
    value = _mapFilterToTodoList();
  }

  List<Todo> _mapFilterToTodoList() => switch (_currentFilter) {
        TodoFilter.pendentes =>
          _todos.where((todo) => !todo.completed).toList(),
        TodoFilter.concluidas =>
          _todos.where((todo) => todo.completed).toList(),
        _ => _todos
      };
}
