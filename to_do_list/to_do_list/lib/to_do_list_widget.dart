import 'package:bloco_de_notas/Todo_Controller.dart';
import 'package:bloco_de_notas/Todo_filter.dart';
import 'package:bloco_de_notas/Todo_item_widget.dart';
import 'package:bloco_de_notas/service_locator.dart';
import 'package:flutter/material.dart';

class ToDoListWidget extends StatelessWidget {
  ToDoListWidget({super.key});

  final controller = getIt<TodolistController>();


  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller.todoListNotifier,
      builder: (context, todoList, child) {
        var isFilterAll = controller.filterNotifier.value == TodoFilter.todas;

        if (todoList.isEmpty && !isFilterAll) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Text('Vazio'),
            ),
          );
        }

        return ReorderableListView.builder(
          primary: false,
          shrinkWrap: true,
          buildDefaultDragHandles: isFilterAll,
          itemCount: todoList.length,
          onReorder: controller.reorder,
          itemBuilder: (context, index) {
            final todo = todoList[index];
            return TodoItemWidget(key: ValueKey(todo.id), todo: todo);
          },
        );
      },
    );
  }
}
