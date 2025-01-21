import 'package:hive/hive.dart';

class bbdd {
  List recetasLlista = [];

  // Box para acceder a la base de datos
  final Box boxTasquesApp = Hive.box("box_tasques_app");

  // Datos de ejemplo
  void crearDadesExemple() {
    recetasLlista = [
      {"titol": "Spaghetti a la boloñesa", "value": 1},
      {"titol": "Albóndigas", "value": 2},
      {"titol": "Paella", "value": 3},
    ];
    actualizarDades(); // Guardar los datos de ejemplo en la base de datos
  }

  // Cargar datos desde Hive
  void cargarDades() {
    final datos = boxTasquesApp.get("recetas");
    if (datos != null) {
      recetasLlista = List<Map<String, dynamic>>.from(datos);
    }
  }

  // Actualizar datos en Hive
  void actualizarDades() {
    boxTasquesApp.put("recetas", recetasLlista);
  }
}
