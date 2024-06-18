// ignore_for_file: file_names

// ignore: unused_import
import 'package:bloco_de_notas/menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bloco_de_notas/Todo_Controller.dart';
import 'package:bloco_de_notas/service_locator.dart';

// ignore: must_be_immutable
class NewTodoWidget extends StatefulWidget {
  final User user;
  
  NewTodoWidget({
    super.key,
    required this.user,
  });

  //NewTodoWidget(user);
  FirebaseFirestore firestore = FirebaseFirestore.instance;

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
