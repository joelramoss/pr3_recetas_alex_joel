import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pr3_recetas_alex_joel/componentes/FormularioReceta.dart';
import 'package:pr3_recetas_alex_joel/data/bbdd.dart';

class Pagina1 extends StatefulWidget {
  final String username;
  const Pagina1({super.key, required this.username});

  @override
  State<Pagina1> createState() => _Pagina1State();
}

class _Pagina1State extends State<Pagina1> {
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
  TextEditingController tecTextTempsPrep = TextEditingController();

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
        db.recetasLlista.add({
          "nom": nombreReceta,
          "urlImagen": tecTextUrlImagen.text,
          "tempsPrep": tecTextTempsPrep.text,
          "descripcion": tecTextDescripcion.text,
          "ingredientes": ingredientes.map((ingrediente) {
            return {
              "nomIngredient": ingrediente["nomIngredient"]!.text,
              "cantidad": ingrediente["cantidad"]!.text
            };
          }).toList(),
        });
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
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          child: FormularioReceta(
            nomReceta: tecTextNom,
            urlImagen: tecTextUrlImagen,
            tempsPrep: tecTextTempsPrep,
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

  // Método para mostrar los detalles de la receta en una ventana emergente
  void verReceta(Map receta) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Row con imagen a la izquierda y detalles a la derecha
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Imagen a la izquierda
                      receta["urlImagen"] != null && receta["urlImagen"] != ""
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                receta["urlImagen"],
                                height: 150,
                                width: 150,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Container(
                              height: 150,
                              width: 150,
                              color: Colors.grey,
                            ),
                      SizedBox(width: 10),
                      // Detalles a la derecha
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              receta["nom"] ?? "Sin nombre",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.teal,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              receta["descripcion"] ?? "Sin descripción",
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 10),
                            // Sección de ingredientes formateada en dos columnas
                            receta.containsKey("ingredientes") &&
                                    receta["ingredientes"] != null &&
                                    receta["ingredientes"].isNotEmpty
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Encabezado
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "Ingredientes:",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              "Cantidad:",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      // Lista de ingredientes
                                      ...receta["ingredientes"]
                                          .map<Widget>((ingrediente) {
                                        return Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                ingrediente["nomIngredient"] ??
                                                    "",
                                                style: TextStyle(fontSize: 16),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                ingrediente["cantidad"] ?? "",
                                                style: TextStyle(fontSize: 16),
                                              ),
                                            ),
                                          ],
                                        );
                                      }).toList(),
                                    ],
                                  )
                                : Container(),
                            SizedBox(height: 10),
                            Text(
                              "Tiempo de preparación: ${receta["tempsPrep"] ?? "No especificado"}",
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Cerrar"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purpleAccent,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mis Recetas"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                Center(child: Text("Iniciado sesión como: ${widget.username}")),
          )
        ],
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
              maxCrossAxisExtent: 320),
          itemCount: db.recetasLlista.length,
          itemBuilder: (context, index) {
            return Dismissible(
              key: Key(db.recetasLlista[index]["nom"]),
              direction: DismissDirection.endToStart,
              background: Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                color: Colors.red,
                child: Icon(Icons.delete, color: Colors.white, size: 30),
              ),
              onDismissed: (direction) {
                eliminarReceta(index);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Receta eliminada")),
                );
              },
              // Al pulsar sobre la tarjeta se muestra la ventana emergente con los detalles
              child: GestureDetector(
                onTap: () {
                  verReceta(db.recetasLlista[index]);
                },
                child: Card(
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
                    ],
                  ),
                ),
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
