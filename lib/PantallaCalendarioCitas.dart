import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'Colores.dart';
import 'databaseHelper.dart';

/// PantallaCalendarioCitas es un widget que muestra un calendario de citas
/// para un usuario específico. Permite mostrar y eliminar citas.
class PantallaCalendarioCitas extends StatefulWidget {
  /// Crea una instancia de [PantallaCalendarioCitas].
  /// 
  /// Requiere el [idUsuario] que identifica al usuario cuyas citas se mostrarán.
  final int idUsuario;

  PantallaCalendarioCitas({required this.idUsuario});

  @override
  _PantallaCalendarioCitasState createState() =>
      _PantallaCalendarioCitasState();
}

class _PantallaCalendarioCitasState extends State<PantallaCalendarioCitas> {
  /// Lista que contiene las citas del usuario.
  List<Map<String, dynamic>> _citas = [];

  /// Indica si las citas están siendo cargadas.
  bool _isLoading = true;

  /// Instancia de [DatabaseHelper] para interactuar con la base de datos.
  final DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _cargarCitas();
  }

  /// Carga las citas del usuario desde la base de datos.
  Future<void> _cargarCitas() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final citas = await _dbHelper.obtenerCitasPorUsuario(widget.idUsuario);

      setState(() {
        _citas = citas;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _mostrarError('Error al cargar las citas');
    }
  }

  /// Muestra un mensaje de error en un [SnackBar].
  ///
  /// [mensaje] es el texto que se mostrará en el [SnackBar].
  void _mostrarError(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensaje),
        backgroundColor: colorRojo,
      ),
    );
  }

  /// Formatea una fecha en formato 'dd/MM/yyyy'.
  ///
  /// [fecha] es la fecha en formato String que se desea formatear.
  /// Retorna la fecha formateada o la fecha original en caso de error.
  String _formatearFecha(String fecha) {
    try {
      final DateTime fechaDateTime = DateTime.parse(fecha);
      return DateFormat('dd/MM/yyyy').format(fechaDateTime);
    } catch (e) {
      return fecha;
    }
  }

  /// Elimina una cita de la base de datos.
  ///
  /// [idCita] es el identificador de la cita que se desea eliminar.
  Future<void> _eliminarCita(int idCita) async {
    try {
      await _dbHelper.eliminarCita(idCita);
      _cargarCitas();
    } catch (e) {
      _mostrarError('Error al eliminar la cita');
    }
  }

  /// Muestra un mensaje en un [SnackBar].
  ///
  /// [mensaje] es el texto que se mostrará en el [SnackBar].
  void _mostrarMensaje(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensaje)),
    );
  }

  /// Construye una tarjeta que representa una cita.
  ///
  /// [cita] es un mapa que contiene la información de la cita.
  Widget _construirTarjetaCita(Map<String, dynamic> cita) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              colorFondo.withOpacity(0.2),
              colorTarjeta,
            ],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      cita['nombre_servicio'] ?? 'Servicio no especificado',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: colorBoton,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete_outline, color: colorRojo),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Confirmar eliminación'),
                          content: Text(
                              '¿Estás seguro de que deseas eliminar esta cita?'),
                          actions: [
                            TextButton(
                              child: Text('Cancelar'),
                              onPressed: () => Navigator.pop(context),
                            ),
                            TextButton(
                              child: Text('Eliminar',
                                  style: TextStyle(color: colorRojo)),
                              onPressed: () {
                                Navigator.pop(context);
                                _eliminarCita(cita['id_cita']);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Icon(Icons.calendar_today, size: 16, color: Colors.grey[600]),
                  SizedBox(width: 8),
                  Text(
                    _formatearFecha(cita['fecha']),
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(width: 16),
                  Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
                  SizedBox(width: 8),
                  Text(
                    cita['hora'],
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[800],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _cargarCitas,
              child: _citas.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.event_busy,
                            size: 64,
                            color: colorGris,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'No tienes citas programadas',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      itemCount: _citas.length,
                      itemBuilder: (context, index) {
                        return _construirTarjetaCita(_citas[index]);
                      },
                    ),
            ),
    );
  }
}