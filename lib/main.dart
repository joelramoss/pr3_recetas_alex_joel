import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:pr3_recetas_alex_joel/pagines/pagina1.dart'; // Asegúrate de que esta ruta sea correcta.

Future <void> main() async {
await Hive.initFlutter();
await Hive.openBox('recetas');

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Pagina1(
        
      )  // Llama al widget de la página 1 aquí.
      
    );
  }
}
