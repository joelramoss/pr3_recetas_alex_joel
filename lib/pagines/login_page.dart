import 'package:flutter/material.dart';
import 'package:pr3_recetas_alex_joel/pagines/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Permite que el AppBar se dibuje sobre el fondo degradado
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Bienvenido', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.purpleAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: const LoginForm(),
          ),
        ),
      ),
    );
  }
}
