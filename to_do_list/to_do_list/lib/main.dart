import 'package:bloco_de_notas/notification_service.dart';
import 'package:bloco_de_notas/service_locator.dart';
// ignore: unused_import
import 'package:bloco_de_notas/to_do_list_page.dart';
import 'package:bloco_de_notas/view/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:flutter/rendering.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'new_ todo_widget.dart';

Future<void> main() async {
  
  setupGetIt();
  
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Hive.initFlutter();
  setupGetIt();

  await Hive.initFlutter();
  setupGetIt();
  await getIt<NotificationService>().init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To Do List',
      theme: ThemeData(
        useMaterial3: false,
        brightness: Brightness.light,
        colorSchemeSeed: Colors.deepPurple,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}


class RoteadordeTelas extends StatelessWidget {
  const RoteadordeTelas({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.userChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.hasData) {
              var newTodoWidget = NewTodoWidget(user: snapshot.data!);
              return newTodoWidget;
            } else {
              return const LoginScreen();
            }
          }
        });
  }
}