import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'Colores.dart';

import 'package:flutter/material.dart';

class PantallaCitas extends StatefulWidget {
  final String servicio; // Variable para almacenar el servicio seleccionado

  // Constructor que acepta el servicio como parámetro
  PantallaCitas({required this.servicio});

  @override
  _PantallaCitasState createState() => _PantallaCitasState();
}

class _PantallaCitasState extends State<PantallaCitas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Citas para ${widget.servicio}'),
      backgroundColor: colorFondo),
      body: Center(
        child: Text('Calendario para las citas de ${widget.servicio}.'),
      ),
    );
  }
}
