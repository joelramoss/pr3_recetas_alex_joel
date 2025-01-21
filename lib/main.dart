import 'package:flutter/material.dart';
import 'package:pr3_recetas_alex_joel/pagines/pagina1.dart'; // Asegúrate de que esta ruta sea correcta.

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Pagina1(bbdd: ), // Llama al widget de la página 1 aquí.
      ),
    );
  }
}
