// services/user_db.dart
import 'package:hive/hive.dart';

class UserDB {
  static Box get _usuariosBox => Hive.box('usuarios');

  /// Comprueba si existe un usuario
  static bool userExists(String username) {
    return _usuariosBox.containsKey(username);
  }

  /// Obtiene los datos del usuario
  static Map? getUser(String username) {
    return _usuariosBox.get(username);
  }

  /// Registra un nuevo usuario
  static Future<void> registerUser(String username, String password) async {
    await _usuariosBox.put(username, {
      'nombre': username,
      'contraseña': password,
    });
  }
}
