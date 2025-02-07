import 'package:Proyecto_segundaEv/view/PantallaLogin.dart';
import 'package:Proyecto_segundaEv/database/databaseHelper.dart';
import 'package:flutter/material.dart';
import '../model/Colores.dart';

/// PantallaRegistro es un widget que permite a los usuarios registrarse
/// en la aplicación proporcionando su nombre, correo electrónico, número de teléfono
/// y contraseña.
class PantallaRegistro extends StatefulWidget {
  @override
  _PantallaRegistroState createState() => _PantallaRegistroState();
}

class _PantallaRegistroState extends State<PantallaRegistro> {
  /// Clave global para el formulario.
  final formKey = GlobalKey<FormState>();

  /// Instancia de [DatabaseHelper] para interactuar con la base de datos.
  final DatabaseHelper _dbHelper = DatabaseHelper();

  /// Controlador para el campo de texto del nombre.
  final _nombreController = TextEditingController();

  /// Controlador para el campo de texto del teléfono.
  final _telefonoController = TextEditingController();

  /// Controlador para el campo de texto del correo electrónico.
  final _correoController = TextEditingController();

  /// Controlador para el campo de texto de la contraseña.
  final _contrasenaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/imagenes/LogoAlba.png', height: 200),
              Container(
                width: 300,
                child: TextFormField(
                  controller: _nombreController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'El nombre y apellidos debe estar relleno';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: 'Nombre y apellidos', filled: true),
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: 300,
                child: TextFormField(
                  controller: _correoController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'El correo electrónico debe estar relleno';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: 'Correo electrónico', filled: true),
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: 300,
                child: TextFormField(
                  controller: _telefonoController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'El número de telefono debe estar relleno';
                    }
                    return null;
                  },
                  decoration:
                      InputDecoration(labelText: 'Nº Telefono', filled: true),
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: 300,
                child: TextFormField(
                  controller: _contrasenaController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'La contraseña debe estar rellena';
                    }
                    return null;
                  },
                  decoration:
                      InputDecoration(labelText: 'Contraseña', filled: true),
                  obscureText: true,
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: 200,
                child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: colorBoton),
                    onPressed: () async {
                      try {
                        bool correoExiste = await _dbHelper
                            .existeCorreo(_correoController.text);
                        if (correoExiste) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  'El correo electrónico ya está registrado')));
                          return;
                        }
                        // Registrar el usuario en la base de datos
                        await _dbHelper.registrarUsuario(
                          _nombreController.text,
                          _telefonoController.text,
                          _correoController.text,
                          _contrasenaController.text,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Usuario registrado con éxito.')));
                        
                        // Limpiar los campos después del registro
                        _nombreController.clear();
                        _telefonoController.clear();
                        _correoController.clear();
                        _contrasenaController.clear();
                        
                        // Navegar a la pantalla de inicio de sesión
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PantallaLogin()));
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content:
                                Text('Error al registrar el usuario: $e')));
                      }
                    },
                    child: Text('Registrarse',
                        style: TextStyle(color: colorLetraB))),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('¿Ya tienes cuenta?'),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PantallaLogin()),
                        );
                      },
                      child: Text('Iniciar sesión'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}