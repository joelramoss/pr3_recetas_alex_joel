import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pr3_recetas_alex_joel/pagines/pagina1.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  String _message = '';

  // Función para iniciar sesión
  void _login() {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();
    final usuariosBox = Hive.box('usuarios');

    if (usuariosBox.containsKey(username)) {
      final userData = usuariosBox.get(username);
      if (userData['contraseña'] == password) {
        // Si el login es exitoso, navegamos a Pagina1 pasando el nombre de usuario
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Pagina1(username: username)),
        );
      } else {
        setState(() {
          _message = 'Contraseña incorrecta.';
        });
      }
    } else {
      setState(() {
        _message = 'El usuario no existe. Por favor, regístrate.';
      });
    }
  }

  // Función para registrar un nuevo usuario
  void _register() {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();
    final usuariosBox = Hive.box('usuarios');

    if (username.isEmpty || password.isEmpty) {
      setState(() {
        _message = 'Por favor, ingrese usuario y contraseña.';
      });
      return;
    }

    if (usuariosBox.containsKey(username)) {
      setState(() {
        _message = 'El usuario ya existe. Por favor, inicia sesión.';
      });
    } else {
      usuariosBox.put(username, {
        'nombre': username,
        'contraseña': password,
      });
      setState(() {
        _message = 'Usuario registrado. Ahora puedes iniciar sesión.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Permite que el AppBar se dibuje sobre el fondo degradado
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Bienvenido',
            style: TextStyle(fontWeight: FontWeight.bold)),
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
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Iniciar sesión",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        labelText: 'Nombre de usuario',
                        prefixIcon: const Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Contraseña',
                        prefixIcon: const Icon(Icons.lock),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: _login,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text('Iniciar sesión'),
                        ),
                        ElevatedButton(
                          onPressed: _register,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purpleAccent,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text('Registrar'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    if (_message.isNotEmpty)
                      Text(
                        _message,
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
