import 'package:flutter/material.dart';

class MyWidget extends StatefulWidget {
  List recetasLlista = [];
   MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: GridView.builder(gridDelegate:,itemCount:  ,itemBuilder:(context, index) {
          
   } ),
      ),
    );
  }
}