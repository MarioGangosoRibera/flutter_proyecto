import 'package:Proyecto_segundaEv/PantallaResgistro.dart';
import 'package:Proyecto_segundaEv/databaseHelper.dart';
import 'package:flutter/material.dart';
import 'Colores.dart';
import 'PantallaServicios.dart';
import 'databaseHelper.dart';

class PantallaLogin extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  DatabaseHelper dbHelper = DatabaseHelper();
  final TextEditingController correoController = TextEditingController();
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
              SizedBox(
                height: 10,
              ),
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
                        bool success = await dbHelper.login(
                          correoController.text, 
                          contrasenaController.text
                        );

                        if(success){
                          //Entra a la pantalla servicios si las credenciales son correctas
                          Navigator.pushReplacement(
                            context, 
                            MaterialPageRoute(builder: (context) => PantallaServicios())
                        );
                        } else {
                          //Credenciales incorrectas
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
