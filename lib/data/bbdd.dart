import 'package:hive/hive.dart';

class bbdd {

  List recetasLlista = [];

  //Box boxTasquesApp = sirve para acceder a la box de dades
  final Box boxTasquesApp = Hive.box("box_tasques_app");

  // Dades de ejemplo
  void crearDadesExemple() { 
    recetasLlista= [
        {"titol": "Spaggetti a la boloñesa", "value": 1},
        {"titol": "Albondigas", "value": 2},
        {"titol": "Paella","value": 3},
    ];
  }
  // Carga de dades
  void CargarDades() {
    // el get sirve para coger datos 
    recetasLlista = boxTasquesApp.get("box_tasques_app");
    
}
// Actualización de dades
void actualizarDades() {
  boxTasquesApp.put("box_tasques_app", recetasLlista);
}
}