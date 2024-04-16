import 'package:bloco_de_notas/Todo_Controller.dart';
import 'package:bloco_de_notas/service_locator.dart';
import 'package:flutter/material.dart';

class NewTodoWidget extends StatefulWidget {
  const NewTodoWidget({
    super.key,
  });

  @override
  State<NewTodoWidget> createState() => _NewTodoWidgetState();
}

class _NewTodoWidgetState extends State<NewTodoWidget> {
  late TextEditingController todoController = TextEditingController();
  final controller = getIt<TodolistController>();
  final todoNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Form(
        key: formKey,
        child: TextFormField(
          focusNode: todoNode,
          controller: todoController,
          decoration: const InputDecoration.collapsed(
            hintText: 'Escreva uma nova Tarefa...',
          ),
          validator: (v) {
            if (v == null || v.isEmpty) {
              return 'Tarefa vazia';
            }
            return null;
          },
          onFieldSubmitted: (_) => onSubmitted(),
        ),
      ),
      trailing: TextButton(
        onPressed: onSubmitted,
        style: TextButton.styleFrom(
          backgroundColor: const Color.fromARGB(59, 180, 136, 255),
        ),
        child: const Text('Salvar'),
      ),
    );
  }

  //PARA SALVAR NOVAS TAREFAS
  void onSubmitted() {
    if (!formKey.currentState!.validate()) return;

    controller.add(todoController.text);
    formKey.currentState!.reset();

    todoNode.unfocus();
  }
}
