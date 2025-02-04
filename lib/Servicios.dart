class Servicios {
  int? idServicio;
  String nombreServicio;

  Servicios({
    this.idServicio,
    required this.nombreServicio,
  });

  Map<String, dynamic> toMap() {
    return {
      'id_servicio': idServicio,
      'nombre_servicio': nombreServicio,
    };
  }

  factory Servicios.fromMap(Map<String, dynamic> map) {
    return Servicios(
      idServicio: map['id_servicio'],
      nombreServicio: map['nombre_servicio'],
    );
  }
}