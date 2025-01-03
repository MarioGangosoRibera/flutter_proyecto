
import 'package:Proyecto_segundaEv/PantallaLogin.dart';
import 'package:Proyecto_segundaEv/databaseHelper.dart';
import 'package:flutter/material.dart';
import 'Colores.dart';

class PantallaRegistro extends StatelessWidget {

  final formKey = GlobalKey<FormState>();
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController telefonoController = TextEditingController();
  final TextEditingController correoController = TextEditingController();
  final TextEditingController contrasenaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registro')),
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
                  controller: nombreController,
                  validator: (value) {
                    if(value!.isEmpty){
                      return 'El nombre y apellidos debe estar relleno';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Nombre y apellidos',
                    filled: true
                  ),
                ),
              ),            
              SizedBox(height: 10),
              Container(
                width: 300,
                child: TextFormField(
                  controller: correoController,
                  validator: (value) {
                    if(value!.isEmpty){
                      return 'El correo electrónico debe estar relleno';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Correo electrónico',
                    filled: true
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: 300,
                child: TextFormField(
                  controller: telefonoController,
                  validator: (value) {
                    if(value!.isEmpty){
                      return 'El número de telefono debe estar relleno';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Nº Telefono',
                    filled: true
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: 300,
                child: TextFormField(
                  controller: contrasenaController,
                  validator: (value) {
                    if(value!.isEmpty){
                      return 'La contraseña debe estar rellena';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    filled: true
                  ),
                  obscureText: true,
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: 200,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorBoton
                  ),
                  onPressed: () async {
                    if(formKey.currentState!.validate()){
                      //Debe ir la logica del resgitrarse
                      DatabaseHelper dbHelper = DatabaseHelper();
                      await dbHelper.registrarUsuario(
                        nombreController.text,
                        telefonoController.text,
                        correoController.text,
                        contrasenaController.text
                      );
                      Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => PantallaLogin()),
                    );
                    }
                  }, 
                  child: Text(
                    'Registrarse',
                    style: TextStyle(color: colorLetraB)
                  )
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('¿Ya tienes cuenta?'),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => PantallaLogin()),
                      );      
                    }, 
                    child: Text('Iniciar sesion')
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}