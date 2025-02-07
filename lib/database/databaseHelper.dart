import 'dart:async';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

/// Clase que maneja la conexión y operaciones de la base de datos.
class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  /// Obtiene la instancia de la base de datos, inicializándola si es necesario.
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  /// Inicializa la base de datos y crea las tablas necesarias.
  Future<Database> _initDatabase() async {
    databaseFactory = databaseFactoryFfi;

    try {
      String path = join(await getDatabasesPath(), 'mi_base_de_datos.db');
      return await openDatabase(
        path,
        version: 1,
        onCreate: (db, version) async {
          await db.execute('''
            CREATE TABLE Usuario(
              id_usuario INTEGER PRIMARY KEY AUTOINCREMENT,
              nombre_apellidos TEXT NOT NULL,
              telefono TEXT NOT NULL,
              correo_electronico TEXT NOT NULL UNIQUE,
              contrasena TEXT NOT NULL
            )
          ''');
          await db.execute('''
            CREATE TABLE Servicios(
              id_servicio INTEGER PRIMARY KEY AUTOINCREMENT,
              nombre_servicio TEXT NOT NULL
            )
          ''');
          await db.execute('''
            CREATE TABLE Cita(
              id_cita INTEGER PRIMARY KEY AUTOINCREMENT,
              fecha TEXT NOT NULL,
              hora TEXT NOT NULL,
              id_usuario INTEGER,
              id_servicio INTEGER,
              FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
              FOREIGN KEY (id_servicio) REFERENCES Servicios(id_servicio)
            )
          ''');
          await db.execute('''
            CREATE TABLE Sesion(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              token TEXT,
              id_usuario INTEGER,
              is_logged_in INTEGER
            )
          ''');
        },
      );
    } catch (e) {
      print("Error al inicializar la base de datos: $e");
      rethrow;
    }
  }

  /// Registra un nuevo usuario en la base de datos.
  ///
  /// [nombre_apellidos] es el nombre y apellidos del usuario.
  /// [telefono] es el número de teléfono del usuario.
  /// [correo] es el correo electrónico del usuario.
  /// [contrasena] es la contraseña del usuario.
  Future<void> registrarUsuario(String nombre_apellidos, String telefono,
      String correo, String contrasena) async {
    final db = await database;
    try {
      await db.insert('Usuario', {
        'nombre_apellidos': nombre_apellidos,
        'telefono': telefono,
        'correo_electronico': correo,
        'contrasena': contrasena
      });
    } catch (e) {
      print("Error al registrar usuario: $e");
    }
  }

  /// Verifica si un correo electrónico ya está registrado en la base de datos.
  ///
  /// [correo] es el correo electrónico a verificar.
  /// Retorna `true` si el correo ya existe, de lo contrario `false`.
  Future<bool> existeCorreo(String correo) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'Usuario',
      where: 'correo_electronico = ?',
      whereArgs: [correo],
    );
    return maps.isNotEmpty;
  }

  /// Intenta iniciar sesión con el correo electrónico y la contraseña proporcionados.
  ///
  /// [correo] es el correo electrónico del usuario.
  /// [contrasena] es la contraseña del usuario.
  /// Retorna `true` si las credenciales son correctas, de lo contrario `false`.
  Future<bool> login(String correo, String contrasena) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'Usuario',
      where: 'correo_electronico = ? AND contrasena = ?',
      whereArgs: [correo, contrasena],
    );
    return maps.isNotEmpty;
  }

  /// Registra una nueva cita en la base de datos.
  ///
  /// [fecha] es la fecha de la cita.
  /// [hora] es la hora de la cita.
  /// [idUsuario] es el identificador del usuario que reserva la cita.
  /// [nombreServicio] es el nombre del servicio asociado a la cita.
  /// [idServicio] es el identificador del servicio.
  Future<int> registrarCita({
    required String fecha,
    required String hora,
    required int idUsuario,
    required String nombreServicio,
    required int idServicio,
  }) async {
    final db = await database;
    final idServicio = await obtenerIdServicio(nombreServicio);

    final id = await db.insert('Cita', {
      'fecha': fecha,
      'hora': hora,
      'id_usuario': idUsuario,
      'id_servicio': idServicio,
    });

    return id;
  }

  /// Obtiene las horas reservadas para una fecha específica.
  ///
  /// [fecha] es la fecha para la cual se desean obtener las horas reservadas.
  /// Retorna una lista de horas reservadas en esa fecha.
  Future<List<String>> obtenerHorasReservadas(DateTime fecha) async {
    final db = await database;
    final List<Map<String, dynamic>> reservas = await db.query(
      'Cita',
      where: 'fecha = ?',
      whereArgs: [fecha.toIso8601String()],
    );

    return reservas.map((reserva) => reserva['hora'] as String).toList();
  }

  /// Elimina una cita de la base de datos.
  ///
  /// [id] es el identificador de la cita que se desea eliminar.
  Future<void> eliminarCita(int id) async {
    final db = await database;
    await db.delete(
      'Cita',
      where: 'id_cita = ?',
      whereArgs: [id],
    );
  }

  /// Obtiene todas las citas reservadas por un usuario específico.
  ///
  /// [idUsuario] es el identificador del usuario cuyas citas se desean obtener.
  /// Retorna una lista de mapas que representan las citas del usuario.
  Future<List<Map<String, dynamic>>> obtenerCitasPorUsuario(
      int idUsuario) async {
    final db = await database;
    try {
      final List<Map<String, dynamic>> result = await db.rawQuery('''
      SELECT 
        Cita.id_cita,
        Cita.fecha,
        Cita.hora,
        Servicios.nombre_servicio
      FROM Cita
      INNER JOIN Servicios ON Cita.id_servicio = Servicios.id_servicio
      WHERE Cita.id_usuario = ?
      ORDER BY 
        DATE(Cita.fecha) ASC, 
        Cita.hora ASC
    ''', [idUsuario]);
      return result;
    } catch (e) {
      print("Error al obtener citas: $e");
      return [];
    }
  }

  /// Cierra la sesión del usuario actual.
  Future<void> cerrarSesion() async {
    final db = await database;

    await db.update(
      'Sesion',
      {
        'token': null,
        'is_logged_in': 0
      }, 
      where: 'id = ?', 
      whereArgs: [1],
    );
  }

  /// Verifica la disponibilidad de una hora específica en una fecha dada.
  ///
  /// [fecha] es la fecha en la que se desea verificar la disponibilidad.
  /// [hora] es la hora que se desea verificar.
  /// Retorna `true` si la hora está disponible, de lo contrario `false`.
  Future<bool> verificarDisponibilidad(DateTime fecha, String hora) async {
    final db = await database;
    final List<Map<String, dynamic>> citas = await db.query(
      'Cita',
      where: 'fecha = ? AND hora = ?',
      whereArgs: [fecha.toIso8601String(), hora],
    );

    return citas.isEmpty; // Si no hay citas, la hora está disponible
  }

  /// Obtiene el identificador de un servicio por su nombre.
  ///
  /// [nombreServicio] es el nombre del servicio a buscar.
  /// Retorna el identificador del servicio. Si no existe, lo crea y retorna su id.
  Future<int> obtenerIdServicio(String nombreServicio) async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query(
      'Servicios',
      where: 'nombre_servicio = ?',
      whereArgs: [nombreServicio],
    );

    if (result.isEmpty) {
      final id =
          await db.insert('Servicios', {'nombre_servicio': nombreServicio});
      return id;
    }

    return result.first['id_servicio'];
  }
}