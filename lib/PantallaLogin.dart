import 'package:Proyecto_segundaEv/PantallaResgistro.dart';
import 'package:Proyecto_segundaEv/databaseHelper.dart';
import 'package:flutter/material.dart';
import 'Colores.dart';
import 'PantallaServicios.dart';

/// PantallaLogin es un widget que permite a los usuarios iniciar sesión
/// en la aplicación utilizando su correo electrónico y contraseña.
class PantallaLogin extends StatelessWidget {
  /// Clave global para el formulario.
  final formKey = GlobalKey<FormState>();

  /// Instancia de [DatabaseHelper] para interactuar con la base de datos.
  DatabaseHelper dbHelper = DatabaseHelper();

  /// Controlador para el campo de texto del correo electrónico.
  final TextEditingController correoController = TextEditingController();

  /// Controlador para el campo de texto de la contraseña.
  final TextEditingController contrasenaController = TextEditingController();

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
                  controller: correoController,
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
                  controller: contrasenaController,
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
                      if (formKey.currentState!.validate()) {
                        // Intenta iniciar sesión con las credenciales proporcionadas
                        bool success = await dbHelper.login(
                          correoController.text, 
                          contrasenaController.text
                        );

                        if(success){
                          // Entra a la pantalla de servicios si las credenciales son correctas
                          Navigator.pushReplacement(
                            context, 
                            MaterialPageRoute(builder: (context) => PantallaServicios())
                        );
                        } else {
                          // Muestra un mensaje de error si las credenciales son incorrectas
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Credenciales incorrectas'))
                          );
                        }
                      }
                    },
                    child: Text('Iniciar sesión',
                        style: TextStyle(color: colorLetraB))),
              ),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('¿No tienes cuenta?'),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PantallaRegistro()),
                        );
                      },
                      child: Text('Registrarse'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}