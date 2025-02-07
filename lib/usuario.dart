/// Clase que representa un usuario en la aplicación.
///
/// La clase [Usuario] contiene información sobre un usuario específico,
/// incluyendo su identificador, nombre, teléfono, correo electrónico y contraseña.
class Usuario {
  int? idUsuario;
  String nombreApellidos;
  String telefono;
  String correoElectronico;
  String contrasena;

  /// Constructor de la clase [Usuario].
  ///
  /// [idUsuario] es opcional y puede ser nulo.
  /// [nombreApellidos], [telefono], [correoElectronico] y [contrasena] son parámetros requeridos.
  Usuario({
    this.idUsuario,
    required this.nombreApellidos,
    required this.telefono,
    required this.correoElectronico,
    required this.contrasena,
  });

  /// Convierte la instancia de [Usuario] a un mapa.
  ///
  /// Retorna un [Map<String, dynamic>] que representa el usuario,
  /// donde las claves son los nombres de las columnas en la base de datos.
  Map<String, dynamic> toMap() {
    return {
      'id_usuario': idUsuario,
      'nombre_apellidos': nombreApellidos,
      'telefono': telefono,
      'correo_electronico': correoElectronico,
      'contrasena': contrasena,
    };
  }

  /// Crea una instancia de [Usuario] a partir de un mapa.
  ///
  /// [map] es un [Map<String, dynamic>] que contiene los datos del usuario.
  /// Retorna una nueva instancia de [Usuario].
  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      idUsuario: map['id_usuario'],
      nombreApellidos: map['nombre_apellidos'],
      telefono: map['telefono'],
      correoElectronico: map['correo_electronico'],
      contrasena: map['contrasena'],
    );
  }
}