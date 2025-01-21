import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pr3_recetas_alex_joel/data/bbdd.dart';

class Pagina1 extends StatefulWidget {
  const Pagina1({super.key});

  @override
  State<Pagina1> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Pagina1> {

  final Box _boxHive = Hive.box('box_tasques_app');
  bbdd db = bbdd();

  @override
  void initState() {
  if (_boxHive.get("box_tasques_app") == null) {
    db.crearDadesExemple();
  }else {
    db.cargarDades();
  }
  super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}