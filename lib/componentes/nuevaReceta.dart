import 'package:flutter/material.dart';


// ignore: must_be_immutable
class nuevaReceta extends StatelessWidget {
  String nomReceta = "";
  String urlimatge = "";
  nuevaReceta({super.key, required this.nomReceta, required this.urlimatge});

  @override
 Widget build(BuildContext context) {
  return AlertDialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    content: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
              Image.network(urlimatge),
            Text(
              nomReceta,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

}