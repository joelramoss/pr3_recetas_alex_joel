import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
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

  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 500),
        itemCount: db.recetasLlista.length,
        itemBuilder: (context, index) {
          return nuevaReceta(
              nomReceta: db.recetasLlista[index]["nom"],
              urlimatge: db.recetasLlista[index]["urlImagen"]);
        },
      ),
    );
  }

  void accioGuardar() {
    setState(() {
      //Guardamos objeto en lista de objetos de la base de datos
    });
    //db.actualizarDades();
  }

  void accioEliminar(int posllista) {
    setState(() {
      db.recetasLlista.removeAt(posllista);
    });
    //db.actualizarDades();
  }

  //* Creacion de nueva receta
  void crearReceta() {
    showDialog(
      context: context,
      builder: (context) {
        return nuevaReceta(
          nomReceta: "",
          urlimatge: "",
        );
      },
    );
  }
}
