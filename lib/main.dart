import 'package:Proyecto_segundaEv/Colores.dart';
import 'package:Proyecto_segundaEv/Pantalla_principal.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Proyecto 2 evaluación',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: colorFondo
      ),
      home: PantallaPrincipal(),
    );
  }
}
