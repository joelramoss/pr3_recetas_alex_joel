import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pr3_recetas_alex_joel/componentes/FormularioReceta.dart';
import 'package:pr3_recetas_alex_joel/componentes/nuevaReceta.dart';
import 'package:pr3_recetas_alex_joel/data/bbdd.dart';

class Pagina1 extends StatefulWidget {
  const Pagina1({super.key});

  @override
  State<Pagina1> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Pagina1> {
  final Box _boxHive = Hive.box('recetas');
  bbdd db = bbdd();

  @override
  void initState() {
    if (_boxHive.get("recetas") == null) {
      db.crearDadesExemple();
    } else {
      db.cargarDades();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 500),
        itemCount: db.recetasLlista.length,
        itemBuilder: (context, index) {
          return nuevaReceta(
              nomReceta: db.recetasLlista[index]["nom"],
              urlimatge: db.recetasLlista[index]["urlImagen"]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: crearReceta,
        child: Icon(Icons.add),
      ),
    );
  }

  // Controladores para los campos de texto
  TextEditingController tecTextNom = TextEditingController();
  TextEditingController tecTextDescripcion = TextEditingController();
  TextEditingController tecTextUrlImagen = TextEditingController();
  
  // Lista dinámica de ingredientes (con nombre y cantidad)
  List<Map<String, TextEditingController>> ingredientes = [];

  void agregarIngrediente() {
    setState(() {
      ingredientes.add({
        "nomIngredient": TextEditingController(),
        "cantidad": TextEditingController(),
      });
    });
  }

  void eliminarIngrediente(int index) {
    setState(() {
      ingredientes.removeAt(index);
    });
  }

void accioGuardar() {
  setState(() {
    // Convertimos la lista de controladores a una lista de Map<String, String>
    List<Map<String, String>> listaIngredientes = ingredientes.map((ing) {
      return {
        "nomIngredient": ing["nomIngredient"]!.text,
        "cantidad": ing["cantidad"]!.text,
      };
    }).toList();

    // Agregamos la nueva receta con el formato correcto
    db.recetasLlista.add({
      "nom": tecTextNom.text,
      "ingredientes": listaIngredientes,
      "descripcion": tecTextDescripcion.text,
      "urlImagen": tecTextUrlImagen.text,
    });

    // Guardamos en la base de datos
    db.actualizarDades();

    // Limpiamos los campos después de guardar
    tecTextNom.clear();
    tecTextDescripcion.clear();
    tecTextUrlImagen.clear();
    ingredientes.clear();
  });

  // Cerramos el diálogo después de guardar
  Navigator.of(context).pop();
}


  void accioCancelar() {
    Navigator.of(context).pop();
    tecTextNom.clear();
    tecTextDescripcion.clear();
    tecTextUrlImagen.clear();
    ingredientes.clear();
  }

  //* Creación de nueva receta
void crearReceta() async {
  final nuevaReceta = await showDialog(
    context: context,
    builder: (context) {
      return FormularioReceta(
        nomReceta: tecTextNom,
        urlImagen: tecTextUrlImagen,
        descripcion: tecTextDescripcion,
        accioCancelar: accioCancelar,
        accioGuardar: null, // No usamos accioGuardar aquí, lo manejamos en el pop
      );
    },
  );

  if (nuevaReceta != null) {
    setState(() {
      db.recetasLlista.add(nuevaReceta);
      db.actualizarDades();
    });
  }
}


}
