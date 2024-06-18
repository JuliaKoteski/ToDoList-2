import 'package:bloco_de_notas/hive_storage.dart';
import 'package:bloco_de_notas/todo_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:bloco_de_notas/api_service.dart';
import 'package:bloco_de_notas/storage_service.dart';
import 'package:bloco_de_notas/notification_service.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  getIt.registerLazySingleton<StorageService>(() => HiveStorage());
  getIt.registerLazySingleton<NotificationService>(() => NotificationService());
  getIt.registerLazySingleton<TodolistController>(() => TodolistController());
 
  getIt.registerLazySingleton<ApiService>(
      () => ApiService('http://localhost:3000/api'));
}
