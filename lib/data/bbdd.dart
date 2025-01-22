import 'package:hive/hive.dart';

class bbdd {
  List recetasLlista = [];

  // Box para acceder a la base de datos
  final Box boxTasquesApp = Hive.box("recetas");

  // Datos de ejemplo
  void crearDadesExemple() {
    recetasLlista = [
      {
        "nom": "Patatas Fritas con Huevos Fritos", 
        "ingredientes": [
          {"nomIngredient" : "Patatas Fritas","cantidad": "100 Gramos"}, 
          {"nomIngredient" : "Huevos Fritos","cantidad": "2"}
        ], 
        "descripcion": "Patatas y huevos", 
        "urlImagen": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQqyjLWKgvWiL_ATsz7BfeWqDFEfQPvBOjuf4XJOiCuYrczEaNre_A2EDO9lbrj88SILLg&usqp=CAU"
      },
      {
        "nom": "Macarrones con tomate", 
        "ingredientes": [
          {"nomIngredient" : "Macarrones","cantidad": "100 Gramos "}, 
          {"nomIngredient" : "Tomate","cantidad": "5ml"}
        ], 
        "descripcion": "Macarrones con tomate", 
        "urlImagen": "https://i.ytimg.com/vi/FnOAdtqaxwc/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLAkRaMrI1BbD7IFg5uzW9IfhxXk1w"
      },

    ];
    actualizarDades(); // Guardar los datos de ejemplo en la base de datos
  }

  // Cargar datos desde Hive
void cargarDades() {
  final datos = boxTasquesApp.get("recetas");
  if (datos != null) {
    recetasLlista = (datos as List).map((item) {
      return Map<String, dynamic>.from(item as Map);
    }).toList();
  }
}


  // Actualizar datos en Hive
  void actualizarDades() {
    boxTasquesApp.put("recetas", recetasLlista);
  }
}
