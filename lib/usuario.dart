class Usuario {
  int? idUsuario;
  String nombreApellidos;
  String telefono;
  String correoElectronico;
  String contrasena;

  Usuario({
    this.idUsuario,
    required this.nombreApellidos,
    required this.telefono,
    required this.correoElectronico,
    required this.contrasena,
  });

  Map<String, dynamic> toMap() {
    return {
      'id_usuario': idUsuario,
      'nombre_apellidos': nombreApellidos,
      'telefono': telefono,
      'correo_electronico': correoElectronico,
      'contrasena': contrasena,
    };
  }

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