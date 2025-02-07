/// Clase que representa un servicio en la aplicación.
///
/// La clase [Servicios] contiene información sobre un servicio específico,
/// incluyendo su identificador y nombre.
class Servicios {
  int? idServicio;
  String nombreServicio;

  /// Constructor de la clase [Servicios].
  ///
  /// [idServicio] es opcional y puede ser nulo.
  /// [nombreServicio] es un parámetro requerido que representa el nombre del servicio.
  Servicios({
    this.idServicio,
    required this.nombreServicio,
  });

  /// Convierte la instancia de [Servicios] a un mapa.
  ///
  /// Retorna un [Map<String, dynamic>] que representa el servicio,
  /// donde las claves son los nombres de las columnas en la base de datos.
  Map<String, dynamic> toMap() {
    return {
      'id_servicio': idServicio,
      'nombre_servicio': nombreServicio,
    };
  }

  /// Crea una instancia de [Servicios] a partir de un mapa.
  ///
  /// [map] es un [Map<String, dynamic>] que contiene los datos del servicio.
  /// Retorna una nueva instancia de [Servicios].
  factory Servicios.fromMap(Map<String, dynamic> map) {
    return Servicios(
      idServicio: map['id_servicio'],
      nombreServicio: map['nombre_servicio'],
    );
  }
}