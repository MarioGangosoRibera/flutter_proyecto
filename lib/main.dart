import 'package:Proyecto_segundaEv/Colores.dart';
import 'package:Proyecto_segundaEv/PantallaPrincipal.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';


void main() {
  databaseFactory = databaseFactoryFfi; // Inicializa el factory

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: colorFondo),
      title: 'Mi Aplicación',
      home: PantallaPrincipal(),
    );
  }
}
