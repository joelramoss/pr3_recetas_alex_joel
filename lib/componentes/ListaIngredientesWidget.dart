import 'package:flutter/material.dart';

class ListaIngredientesWidget extends StatefulWidget {
  final List<Map<String, TextEditingController>> ingredientes;
  final Function agregarIngrediente;
  final Function(int) eliminarIngrediente;

  const ListaIngredientesWidget({
    Key? key,
    required this.ingredientes,
    required this.agregarIngrediente,
    required this.eliminarIngrediente,
  }) : super(key: key);

  @override
  _ListaIngredientesWidgetState createState() =>
      _ListaIngredientesWidgetState();
}

class _ListaIngredientesWidgetState extends State<ListaIngredientesWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: List.generate(widget.ingredientes.length, (index) {
            return Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: widget.ingredientes[index]["nomIngredient"],
                    decoration: InputDecoration(
                      labelText: 'Ingrediente',
                      hintText: 'Ej: Harina',
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    controller: widget.ingredientes[index]["cantidad"],
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
                    widget.eliminarIngrediente(index);
                  },
                ),
              ],
            );
          }),
        ),
        const SizedBox(height: 10),
        ElevatedButton.icon(
          onPressed: () => widget.agregarIngrediente(),
          icon: Icon(Icons.add),
          label: Text('Añadir ingrediente'),
        ),
      ],
    );
  }
}
