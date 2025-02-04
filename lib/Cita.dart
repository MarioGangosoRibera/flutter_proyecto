class Cita {
  int? idCita;
  String fecha;
  String hora;
  int idUsuario;
  int idServicio;

  Cita({
    this.idCita,
    required this.fecha,
    required this.hora,
    required this.idUsuario,
    required this.idServicio,
  });

  Map<String, dynamic> toMap() {
    return {
      'id_cita': idCita,
      'fecha': fecha,
      'hora': hora,
      'id_usuario': idUsuario,
      'id_servicio': idServicio,
    };
  }

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