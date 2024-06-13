import 'package:bloco_de_notas/main.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:bloco_de_notas/notification_service.dart';
import 'package:bloco_de_notas/service_locator.dart';

void main() async {
  await Hive.initFlutter();
  setupGetIt();
  await getIt<NotificationService>().init();
  runApp(const MyApp());
}
