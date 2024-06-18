import 'package:bloco_de_notas/New_%20Todo_widget.dart';
import 'package:bloco_de_notas/To_do_List_widget.dart';
import 'package:bloco_de_notas/Todo_Controller.dart';
import 'package:bloco_de_notas/Todo_filter.dart';
import 'package:bloco_de_notas/service_locator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: unused_import
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final controller = getIt<TodolistController>();
  static const List<Tab> tabs = [
    Tab(text: 'Todas'),
    Tab(text: 'Pendentes'),
    Tab(text: 'Concluídas'),
  ];

  @override
  void initState() {
    controller.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('To Do List'),
          centerTitle: true,
          bottom: TabBar(
            tabs: tabs,
            onTap: (index) {
              controller.changeFilter(TodoFilter.values[index]);
            },
          ),
        ),
        body: ListView(children: [
          ValueListenableBuilder(
              valueListenable: controller.filterNotifier,
              builder: (context, filter, child) {
                if (filter == TodoFilter.concluidas) {
                  return const SizedBox.shrink();
                }

                User? user = FirebaseAuth.instance.currentUser;

                if (user == null) {
                  return const Text('Usuário não autenticado');
                }

                return NewTodoWidget(user: user);
              }),
          ToDoListWidget(),
        ]),
        backgroundColor: Colors.deepPurple.shade50,
      ),
    );
  }
}
