import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../database/databaseHelper.dart';
import '../model/Colores.dart';

/// PantallaCitas es un widget que permite a los usuarios seleccionar una fecha
/// y hora para reservar una cita para un servicio específico.
class PantallaCitas extends StatefulWidget {
  /// Crea una instancia de [PantallaCitas].
  ///
  /// Requiere el [servicioSeleccionado] que indica el servicio para el cual
  /// se está pidiendo la cita y el [idUsuario] que identifica al usuario.
  final String servicioSeleccionado;
  final int idUsuario;

  PantallaCitas({
    required this.servicioSeleccionado,
    required this.idUsuario,
  });

  @override
  _PantallaPedirCitaState createState() => _PantallaPedirCitaState();
}

class _PantallaPedirCitaState extends State<PantallaCitas> {
  /// Día seleccionado para la cita.
  late DateTime _selectedDay;

  /// Servicio seleccionado por el usuario.
  late String _selectedService;

  /// Lista de horas disponibles para reservar.
  List<String> _availableHours = [];

  /// Lista de citas reservadas por el usuario.
  List<Map<String, dynamic>> _citasReservadas = [];

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now(); // Inicializa el día seleccionado a hoy.
    _selectedService = widget.servicioSeleccionado; // Servicio seleccionado.
    _buscarHorasDisponibles(); // Cargar horas disponibles.
    _buscarCitasReservadas(); // Cargar citas reservadas.
  }

  /// Obtiene las horas disponibles para el día seleccionado.
  void _buscarHorasDisponibles() async {
    // Obtener las horas reservadas para el día seleccionado.
    List<String> horasReservadas =
        await DatabaseHelper().obtenerHorasReservadas(_selectedDay);

    // Definir todas las horas posibles.
    List<String> todasLasHoras = [
      '09:00',
      '10:00',
      '11:00',
      '12:00',
      '13:00',
      '16:00',
      '17:00',
      '18:00'
    ];

    // Filtrar las horas disponibles.
    setState(() {
      _availableHours = todasLasHoras
          .where((hora) => !horasReservadas.contains(hora))
          .toList();
    });
  }

  /// Obtiene las citas reservadas para el usuario actual.
  _buscarCitasReservadas() async {
    List<Map<String, dynamic>> citas =
        await DatabaseHelper().obtenerCitasPorUsuario(widget.idUsuario);
    setState(() {
      _citasReservadas = citas;
    });
  }

  /// Guarda una cita en la base de datos.
  ///
  /// [hour] es la hora seleccionada para la cita.
  void _guardarCita(String hour) async {
    DatabaseHelper dbHelper = DatabaseHelper();
    bool disponible =
        await dbHelper.verificarDisponibilidad(_selectedDay, hour);

    if (disponible) {
      try {
        int idServicio = await dbHelper.obtenerIdServicio(_selectedService);

        await dbHelper.registrarCita(
          fecha: _selectedDay.toIso8601String(),
          hora: hour,
          idServicio: idServicio,
          nombreServicio: _selectedService,
          idUsuario: widget.idUsuario, // Usar el idUsuario del widget
        );

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Cita guardada con éxito')));
        Navigator.pop(context);
      } catch (e) {
        print("Error al guardar la cita: $e");
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error al guardar la cita')));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Esta hora ya no está disponible')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorFondo,
        title: Text('Pedir Cita'),
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
                _buscarHorasDisponibles(); // Actualizar horas disponibles al seleccionar un día.
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
                    _guardarCita(_availableHours[index]); // Guardar cita al seleccionar hora.
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