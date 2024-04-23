import 'package:flutter/material.dart';
import 'package:flutter_app_2/models/expences.dart';
import 'package:flutter_app_2/pages/expences.dart';
import 'package:flutter_app_2/server/category_adapter.dart';
// import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ExpenceModeAdapter());
  Hive.registerAdapter(CategoryAdapter());
  await Hive.openBox('expencesDB');

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ExpencesApp(),
    );
  }
}
