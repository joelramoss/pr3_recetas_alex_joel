// drawer.dart
import 'package:flutter/material.dart';
import 'package:pr3_recetas_alex_joel/pagines/login_page.dart'; // Importa la pantalla de login

class ddrawer extends StatelessWidget {
  final VoidCallback onCrearReceta; // Callback para crear receta

  const ddrawer({Key? key, required this.onCrearReceta}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.lightBlueAccent, // Color de fondo del drawer
        child: Column(
          children: [
            // Header del drawer (opcional)
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Center(
                child: Text(
                  'Menú',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            // Apartado para "Crear receta"
            ListTile(
              leading: Icon(Icons.add, color: Colors.white),
              title: Text(
                'Crear receta',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              onTap: () {
                // Primero cierra el drawer
                Navigator.of(context).pop();
                // Luego llama a la función para crear receta
                onCrearReceta();
              },
            ),
            Divider(color: Colors.white54),
            // Botón para "Cerrar sesión"
            ListTile(
              leading: Icon(Icons.logout, color: Colors.white),
              title: Text(
                'Cerrar sesión',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              onTap: () {
                // Aquí puedes limpiar datos de sesión si fuera necesario
                // Luego, navega a la pantalla de login sin usar rutas nombradas:
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
