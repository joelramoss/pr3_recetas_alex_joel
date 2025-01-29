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
    super.initState();
    if (_boxHive.get("recetas") == null) {
      db.crearDadesExemple();
    } else {
      db.cargarDades(); 
    }
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

  void accioGuardar(String nombreReceta) {
    if (db.recetasLlista.any((receta) => receta["nom"] == nombreReceta)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Esta receta ya existe')),
      );
    } else {
      setState(() {
        db.recetasLlista.add({"nom": nombreReceta, "urlImagen": ""});
      });
      db.actualizarDades();
    }
  }

  // Función para eliminar una receta
  void eliminarReceta(int index) {
    setState(() {
      db.recetasLlista.removeAt(index);
      db.actualizarDades();
    });
  }

  // Creación de nueva receta
  void crearReceta() async {
    final nuevaReceta = await showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          child: FormularioReceta(
            nomReceta: tecTextNom,
            urlImagen: tecTextUrlImagen,
            descripcion: tecTextDescripcion,
            accioCancelar: accioCancelar,
            accioGuardar: () => accioGuardar(tecTextNom.text),
          ),
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

  void accioCancelar() {
    Navigator.of(context).pop();
    tecTextNom.clear();
    tecTextDescripcion.clear();
    tecTextUrlImagen.clear();
    ingredientes.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mis Recetas"),
        backgroundColor: Colors.teal,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueAccent, Colors.purpleAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue[50]!, Colors.purple[50]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 500),
          itemCount: db.recetasLlista.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 5,
              margin: EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      db.recetasLlista[index]["urlImagen"] ?? "",
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      db.recetasLlista[index]["nom"],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      // Confirmación de eliminación de una receta
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Eliminar receta"),
                            content: Text("¿Estás seguro de que quieres eliminar esta receta?"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  eliminarReceta(index);
                                  Navigator.of(context).pop();
                                },
                                child: Text("Sí, eliminar"),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("Cancelar"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: crearReceta,
        child: Icon(Icons.add),
        backgroundColor: Colors.purpleAccent,
      ),
    );
  }
}
