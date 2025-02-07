import 'package:Proyecto_segundaEv/PantallaLogin.dart';
import 'package:Proyecto_segundaEv/databaseHelper.dart';
import 'package:flutter/material.dart';
import 'Colores.dart';

class PantallaRegistro extends StatefulWidget {
  @override
  _PantallaRegistroState createState() => _PantallaRegistroState();
}

class _PantallaRegistroState extends State<PantallaRegistro> {
  final formKey = GlobalKey<FormState>();
  final DatabaseHelper _dbHelper = DatabaseHelper();
  final _nombreController = TextEditingController();
  final _telefonoController = TextEditingController();
  final _correoController = TextEditingController();
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
                        //Verificar si el correo ya existe
                        bool correoExiste = await _dbHelper
                            .existeCorreo(_correoController.text);
                        if (correoExiste) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  'El correo electrónico ya está registrado')));
                          return;
                        }
                        await _dbHelper.registrarUsuario(
                          _nombreController.text,
                          _telefonoController.text,
                          _correoController.text,
                          _contrasenaController.text,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Usuario registrado con exito.')));
                        //Limpiar los campos después del registro
                        _nombreController.clear();
                        _telefonoController.clear();
                        _correoController.clear();
                        _contrasenaController.clear();
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
                      child: Text('Iniciar sesion'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
