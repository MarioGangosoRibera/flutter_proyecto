import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'databaseHelper.dart'; // Asegúrate de importar tu helper de base de datos

class PantallaCitas extends StatefulWidget {
  final String servicioSeleccionado; // Servicio pasado desde la pantalla anterior

  PantallaCitas({required this.servicioSeleccionado});

  @override
  _PantallaPedirCitaState createState() => _PantallaPedirCitaState();
}

class _PantallaPedirCitaState extends State<PantallaCitas> {
  late DateTime _selectedDay;
  late String _selectedService;
  List<String> _availableHours = []; // Lista de horas disponibles

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    _selectedService = widget.servicioSeleccionado; // Servicio seleccionado
    _fetchAvailableHours(); // Cargar horas disponibles
  }

  void _fetchAvailableHours() async {
    // Obtener las horas reservadas para el día seleccionado
    List<String> horasReservadas = await DatabaseHelper().obtenerHorasReservadas(_selectedDay);

    // Definir todas las horas posibles
    List<String> todasLasHoras = ['09:00', '10:00', '11:00', '14:00', '15:00'];

    // Filtrar las horas disponibles
    setState(() {
      _availableHours = todasLasHoras.where((hora) => !horasReservadas.contains(hora)).toList();
    });
  }

  void _saveAppointment(String hour) async {
    // Guarda la cita en la base de datos
    DatabaseHelper dbHelper = DatabaseHelper();
    await dbHelper.registrarCita(
      fecha: _selectedDay.toIso8601String(),
      hora: hour,
      idUsuario: 1, // Cambia esto por el ID del usuario actual
      idServicio: 1, // Cambia esto por el ID del servicio seleccionado
    );

    // Mostrar un mensaje de éxito
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Cita guardada con éxito')),
    );

    // Regresar a la pantalla anterior o hacer otra acción
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title : Text('Pedir Cita'),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _selectedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _fetchAvailableHours(); // Actualizar horas disponibles al seleccionar un día
              });
            },
          ),
          DropdownButton<String>(
            value: _selectedService,
            items: <String>[
              'Pérdida de peso y recomposición corporal',
              'Nutrición en patologias deportivas',
              'Alimentación vegetariana y vegana',
              'Nutrición clínica',
              'Trastornos de la Conducta Alimentaria'
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedService = newValue!;
              });
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _availableHours.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_availableHours[index]),
                  onTap: () {
                    _saveAppointment(_availableHours[index]); // Guardar cita al seleccionar hora
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}