import 'package:Proyecto_segundaEv/model/Cita.dart';
import 'package:flutter/material.dart';


class CitaWidget extends StatelessWidget {
  final Cita cita;

  const CitaWidget({Key? key, required this.cita}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      key: Key('cita_card'), // Clave para identificar el widget en pruebas
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Fecha: ${cita.fecha}',
              key: Key('fecha'), // Clave para el test
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 8),
            Text(
              'Hora: ${cita.hora}',
              key: Key('hora'), // Clave para el test
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}