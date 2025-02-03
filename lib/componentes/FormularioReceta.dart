import 'package:flutter/material.dart';

class FormularioReceta extends StatefulWidget {
  final TextEditingController nomReceta;
  final TextEditingController urlImagen;
  final TextEditingController descripcion;
  final TextEditingController tempsPrep;
  final Function()? accioGuardar;
  final Function()? accioCancelar;

  const FormularioReceta({
    super.key,
    required this.nomReceta,
    required this.urlImagen,
    required this.descripcion,
    required this.tempsPrep,
    required this.accioGuardar,
    required this.accioCancelar,
  });

  @override
  _FormularioRecetaState createState() => _FormularioRecetaState();
}

class _FormularioRecetaState extends State<FormularioReceta> {
  // Lista de ingredientes manejada internamente
  List<Map<String, TextEditingController>> ingredientes = [];

  @override
  void initState() {
    super.initState();
    agregarIngrediente(); // Agregar un ingrediente vacío al inicio
  }

  // Agregar un nuevo ingrediente a la lista
  void agregarIngrediente() {
    setState(() {
      ingredientes.add({
        "nomIngredient": TextEditingController(),
        "cantidad": TextEditingController(),
      });
    });
  }

  // Eliminar un ingrediente por su índice
  void eliminarIngrediente(int index) {
    setState(() {
      ingredientes.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Campo para el nombre de la receta
              TextFormField(
                controller: widget.nomReceta,
                decoration: InputDecoration(
                  labelText: 'Nombre de la receta',
                  hintText: 'Ingrese el nombre de la receta',
                ),
              ),
              const SizedBox(height: 10),

              // **LISTA DINÁMICA DE INGREDIENTES**
              Column(
                children: List.generate(ingredientes.length, (index) {
                  return Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: ingredientes[index]["nomIngredient"],
                          decoration: InputDecoration(
                            labelText: 'Ingrediente',
                            hintText: 'Ej: Harina',
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          controller: ingredientes[index]["cantidad"],
                          decoration: InputDecoration(
                            labelText: 'Cantidad',
                            hintText: 'Ej: 200g',
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      IconButton(
                        icon: Icon(Icons.remove_circle, color: Colors.red),
                        onPressed: () {
                          eliminarIngrediente(index);
                        },
                      ),
                    ],
                  );
                }),
              ),

              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: agregarIngrediente,
                icon: Icon(Icons.add),
                label: Text('Añadir ingrediente'),
              ),

              const SizedBox(height: 10),
              TextFormField(
                controller: widget.tempsPrep,
                decoration: InputDecoration(
                  labelText: 'Tiempo de preparación',
                  hintText: 'Ingrese el tiempo de preparación',
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: widget.descripcion,
                decoration: InputDecoration(
                  labelText: 'Descripción',
                  hintText: 'Ingrese la descripción de la receta',
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: widget.urlImagen,
                decoration: InputDecoration(
                  labelText: 'URL de la imagen',
                  hintText: 'Ingrese la URL de la imagen',
                ),
              ),
              const SizedBox(height: 20),

// BOTÓN PARA GUARDAR
              ElevatedButton(
                onPressed: () {
                  if (widget.nomReceta.text.isNotEmpty) {
                    // Convertir la lista de ingredientes a formato JSON
                    List<Map<String, String>> listaIngredientes =
                        ingredientes.map((ing) {
                      return {
                        "nomIngredient": ing["nomIngredient"]!.text,
                        "cantidad": ing["cantidad"]!.text,
                      };
                    }).toList();

                    // Devolver los datos al cerrar el formulario, incluyendo el tiempo de preparación
                    Navigator.pop(context, {
                      "nom": widget.nomReceta.text,
                      "descripcion": widget.descripcion.text,
                      "ingredientes": listaIngredientes,
                      "urlImagen": widget.urlImagen.text,
                      "tempsPrep": widget.tempsPrep
                          .text, // Se agrega el tiempo de preparación aquí
                    });
                  }
                },
                child: Text('Guardar Receta'),
              ),

              // BOTÓN PARA CANCELAR
              TextButton(
                onPressed: widget.accioCancelar,
                child: Text('Cancelar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
