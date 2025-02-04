import 'package:flutter/material.dart';
import 'databaseHelper.dart'; // Asegúrate de importar tu helper de base de datos

class PantallaCalendario extends StatefulWidget {
  final int idUsuario; // ID del usuario actual

  PantallaCalendario({required this.idUsuario});

  @override
  _PantallaCalendarioState createState() => _PantallaCalendarioState();
}

class _PantallaCalendarioState extends State<PantallaCalendario> {
  List<Map<String, dynamic>> _citas = [];

  @override
  void initState() {
    super.initState();
    _fetchCitas();
  }

  void _fetchCitas() async {
    List<Map<String, dynamic>> citas = await DatabaseHelper().obtenerCitasPorUsuario(widget.idUsuario);
    setState(() {
      _citas = citas;
    });
  }

  void _eliminarCita(int id) async {
    // Verificar si se puede eliminar la cita (24 horas antes)
    final cita = _citas.firstWhere((cita) => cita['id'] == id);
    DateTime fechaCita = DateTime.parse(cita['fecha']);
    DateTime horaCita = DateTime.parse('${cita['fecha']} ${cita['hora']}');
    DateTime ahora = DateTime.now();

    // Calcular la diferencia en horas
    Duration diferencia = horaCita.difference(ahora);
    if (diferencia.inHours >= 24) {
      await DatabaseHelper().eliminarCita(id);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Cita eliminada con éxito')),
      );
      _fetchCitas(); // Actualizar la lista de citas
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No se puede eliminar la cita, debe ser 24 horas antes')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mis Citas'),
      ),
      body: ListView.builder(
        itemCount: _citas.length,
        itemBuilder: (context, index) {
          final cita = _citas[index];
          return Card(
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              title: Text('Servicio: ${cita['id_servicio']}'), // Cambia esto por el nombre del servicio
              subtitle: Text('Fecha: ${cita['fecha']}, Hora: ${cita['hora']}'),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () => _eliminarCita(cita['id']),
              ),
            ),
          );
        },
      ),
    );
  }
}