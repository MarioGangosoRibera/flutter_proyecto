import 'dart:async';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    // Usar databaseFactoryFfi para soporte en escritorio
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

  Future<bool> existeCorreo(String correo) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'Usuario',
      where: 'correo_electronico = ?',
      whereArgs: [correo],
    );
    return maps.isNotEmpty; // Devuelve true si el correo ya existe
  }

  Future<bool> login(String correo, String contrasena) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'Usuario',
      where: 'correo_electronico = ? AND contrasena = ?',
      whereArgs: [correo, contrasena],
    );
    return maps.isNotEmpty; // Verdadero si el usuario existe
  }

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

  Future<List<String>> obtenerHorasReservadas(DateTime fecha) async {
    final db = await database;
    final List<Map<String, dynamic>> reservas = await db.query(
      'Cita',
      where: 'fecha = ?',
      whereArgs: [fecha.toIso8601String()],
    );

    // Extraer las horas reservadas
    return reservas.map((reserva) => reserva['hora'] as String).toList();
  }

  Future<void> eliminarCita(int id) async {
    final db = await database;
    await db.delete(
      'Cita',
      where: 'id_cita = ?',
      whereArgs: [id],
    );
  }

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

      print("Citas obtenidas: $result"); // Para depuración
      return result;
    } catch (e) {
      print("Error al obtener citas: $e");
      return [];
    }
  }

  Future<void> cerrarSesion() async {
    final db = await database;

    await db.update(
      'Sesion',
      {
        'token': null,
        'is_logged_in': 0
      }, // Limpia el token y marca como no logueado
      where: 'id = ?', // O si solo hay un único registro de sesión
      whereArgs: [1],
    );
  }

  Future<bool> verificarDisponibilidad(DateTime fecha, String hora) async {
    final db = await database;
    final List<Map<String, dynamic>> citas = await db.query(
      'Cita',
      where: 'fecha = ? AND hora = ?',
      whereArgs: [fecha.toIso8601String(), hora],
    );

    return citas.isEmpty; // Si no hay citas, la hora está disponible
  }

  Future<int> obtenerIdServicio(String nombreServicio) async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query(
      'Servicios',
      where: 'nombre_servicio = ?',
      whereArgs: [nombreServicio],
    );

    if (result.isEmpty) {
      // Si el servicio no existe, lo creamos
      final id =
          await db.insert('Servicios', {'nombre_servicio': nombreServicio});
      return id;
    }

    return result.first['id_servicio'];
  }
}
