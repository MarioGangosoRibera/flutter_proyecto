import 'package:Proyecto_segundaEv/model/Colores.dart';
import 'package:Proyecto_segundaEv/view/PantallaPrincipal.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

/// Punto de entrada de la aplicación.
///
/// La función [main] inicializa el entorno de la base de datos y ejecuta la aplicación.
void main() {
  databaseFactory = databaseFactoryFfi;
  sqfliteFfiInit(); 
  runApp(MyApp()); 
}

/// Clase principal de la aplicación.
///
/// Esta clase configura el tema y la pantalla inicial de la aplicación.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: colorFondo),
      title: 'Alba Donado Nutricion',
      home: PantallaPrincipal(),
    );
  }
}