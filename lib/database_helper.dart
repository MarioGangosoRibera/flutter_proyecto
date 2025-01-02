import 'dart:async';
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
      },
    );
  }

  Future<void> registrarUsuario(String nombre_apellidos, String telefono, String correo, String contrasena) async {
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

  Future<bool> login(String correo, String contrasena) async {
  final db = await database;
  final List<Map<String, dynamic>> maps = await db.query(
    'Usuario',
    where: 'correo_electronico = ? AND contrasena = ?',
    whereArgs: [correo, contrasena],
  );
  return maps.isNotEmpty; // Verdadero si el usuario existe
}
}