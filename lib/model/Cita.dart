/// Clase que representa una cita en la aplicación.
///
/// La clase [Cita] contiene información sobre una cita específica,
/// incluyendo su identificador, fecha, hora, y los identificadores del usuario
/// y del servicio asociado.
class Cita {
  int? idCita;
  String fecha;
  String hora;
  int idUsuario;
  int idServicio;

  /// Constructor de la clase [Cita].
  ///
  /// [idCita] es opcional y puede ser nulo.
  /// [fecha], [hora], [idUsuario] y [idServicio] son parámetros requeridos.
  Cita({
    this.idCita,
    required this.fecha,
    required this.hora,
    required this.idUsuario,
    required this.idServicio,
  });

  /// Convierte la instancia de [Cita] a un mapa.
  ///
  /// Retorna un [Map<String, dynamic>] que representa la cita,
  /// donde las claves son los nombres de las columnas en la base de datos.
  Map<String, dynamic> toMap() {
    return {
      'id_cita': idCita,
      'fecha': fecha,
      'hora': hora,
      'id_usuario': idUsuario,
      'id_servicio': idServicio,
    };
  }

  /// Crea una instancia de [Cita] a partir de un mapa.
  ///
  /// [map] es un [Map<String, dynamic>] que contiene los datos de la cita.
  /// Retorna una nueva instancia de [Cita].
  factory Cita.fromMap(Map<String, dynamic> map) {
    return Cita(
      idCita: map['id_cita'],
      fecha: map['fecha'],
      hora: map['hora'],
      idUsuario: map['id_usuario'],
      idServicio: map['id_servicio'],
    );
  }
}