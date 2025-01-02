import 'package:Proyecto_segundaEv/PantallaResgistro.dart';
import 'package:flutter/material.dart';
import 'Colores.dart';
import 'PantallaServicios.dart';

class PantallaLogin extends StatelessWidget {

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
                  validator: (value){
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
              SizedBox(height: 10,),
              Container(
                width: 300,
                child: TextFormField(
                  validator: (value){
                    if(value!.isEmpty){
                      return 'La contraseña debe estar relleno';
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
                  onPressed: (){
                    if(formKey.currentState!.validate()){
                      //Debe ir la logica del iniciar sesion
                      //De momento lo pongo asi para poder entrar a las siguientes pantallas
                      Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => PantallaServicios()),
                    );
                    }
                    
                  }, 
                  child: Text(
                    'Iniciar sesión',
                    style: TextStyle(color: colorLetraB)
                  )
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('¿No tienes cuenta?'),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => PantallaRegistro()),
                      );      
                    }, 
                    child: Text('Registrarse')
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