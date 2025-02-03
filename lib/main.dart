import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pr3_recetas_alex_joel/pagines/login_page.dart';


Future<void> main() async {
  await Hive.initFlutter();
  await Future.wait([
    Hive.openBox('usuarios'),
    Hive.openBox('recetas'),
  ]);
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login Demo',
      home: LoginPage(),
    );
  }
}
