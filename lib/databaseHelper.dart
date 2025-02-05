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

  Future<void> registrarCita({
    required String fecha,
    required String hora,
    required int idUsuario,
    required int idServicio,
  }) async {
    final db = await database; // Obtén la base de datos
    await db.insert('Cita', {
      'fecha': fecha,
      'hora': hora,
      'id_usuario': idUsuario,
      'id_servicio': idServicio,
    });
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
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Map<String, dynamic>>> obtenerCitasPorUsuario(
      int idUsuario) async {
    final db = await database;
    return await db.query('Cita', where: 'id_usuario = ?', whereArgs: [
      idUsuario,
    ]);
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
}
