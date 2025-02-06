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
  List<Map<String, dynamic>> _citasReservadas = []; //LIsta de citas reservadas 

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    _selectedService = widget.servicioSeleccionado; // Servicio seleccionado
    _fetchAvailableHours(); // Cargar horas disponibles
    _fetchCitasReservadas();
  }
  

  void _fetchAvailableHours() async {
    // Obtener las horas reservadas para el día seleccionado
    List<String> horasReservadas = await DatabaseHelper().obtenerHorasReservadas(_selectedDay);

    // Definir todas las horas posibles
    List<String> todasLasHoras = ['09:00', '10:00', '11:00', '12:00', '13:00', '16:00', '17:00', '18:00'];

    // Filtrar las horas disponibles
    setState(() {
      _availableHours = todasLasHoras.where((hora) => !horasReservadas.contains(hora)).toList();
    });
  }

  _fetchCitasReservadas() async{
    //Obtener las ciyas reservadas para el usuario actual
    List<Map<String, dynamic>> citas = await DatabaseHelper().obtenerCitasPorUsuario(1);
    setState(() {
      _citasReservadas = citas;
    });
  }

  void _saveAppointment(String hour) async {
    // Guarda la cita en la base de datos
    DatabaseHelper dbHelper = DatabaseHelper();
    bool disponible = await dbHelper.verificarDisponibilidad(_selectedDay, hour);
    if(disponible){
      //Guarda la cita si esta disponible
      await dbHelper.registrarCita(
      fecha: _selectedDay.toIso8601String(),
      hora: hour,
      idUsuario: 1, // Cambia esto por el ID del usuario actual
      idServicio: 1, // Cambia esto por el ID del servicio seleccionado
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Cita guardada con éxito'))
    );
    _fetchCitasReservadas();
    Navigator.pop(context);
    } else {
      //Si la hora no esta disponible
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('La hora seleccionada ya está reservada'))
      );
    }
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
            firstDay: DateTime.utc(2025, 1, 1),
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
          Expanded(
            child: ListView.builder(
              itemCount: _citasReservadas.length,
              itemBuilder: (context, index) {
                final cita = _citasReservadas[index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text('Servicio: ${cita['nombre_servicio']}'), // Cambia esto por el nombre del servicio
                    subtitle: Text('Fecha: ${cita['fecha']}, Hora: ${cita['hora']}'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}