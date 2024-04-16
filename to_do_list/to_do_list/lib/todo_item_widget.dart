import 'package:bloco_de_notas/Todo_Controller.dart';
import 'package:bloco_de_notas/service_locator.dart';
import 'package:flutter/material.dart';

import 'To_do.dart';

class TodoItemWidget extends StatefulWidget {
  const TodoItemWidget({super.key, required this.todo});

  final Todo todo;

  @override
  State<TodoItemWidget> createState() => _TodoItemWidgetState();
}

class _TodoItemWidgetState extends State<TodoItemWidget> {
  late TextEditingController todoController;
  final controller = getIt<TodolistController>();

  @override
  void initState() {
    todoController = TextEditingController(text: widget.todo.task);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: TextFormField(
        controller: todoController,
        decoration: const InputDecoration.collapsed(
          hintText: 'Escreva sua Tarefa',
        ),
        onChanged: onChanged,
      ),
      leading: Checkbox(
        checkColor: Colors.white,
        activeColor: Colors.deepPurple,
        value: widget.todo.completed,
        onChanged: onToggled,
      ),
      trailing: IconButton(
        iconSize: 20,
        color: Colors.deepPurple,
        onPressed: onDeleted,
        visualDensity: VisualDensity.compact,
        icon: const Icon(Icons.close_rounded),
      ),
    );
  }

  void onChanged(String task) {
    controller.update(widget.todo.id, task);
  }

  //PARA MARCAR CHECKBOX
  void onToggled(_) {
    controller.toggle(widget.todo.id);
  }

  //PARA DELETAR TAREFAS
  void onDeleted() {
    controller.remove(widget.todo.id);
  }
}
