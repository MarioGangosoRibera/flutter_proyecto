
import 'package:flutter/material.dart';
import 'Colores.dart';
import 'PantallaServicios.dart';

class PantallaRegistro extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registro')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/imagenes/LogoAlba.png', height: 200),
            TextField(
              decoration: InputDecoration(
                labelText: 'Nombre y apellidos',
                filled: true
              ),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                labelText: 'Correo electrónico',
                filled: true
              ),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                labelText: 'Nº Telefono',
                filled: true
              ),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                labelText: 'Contraseña',
                filled: true
              ),
              obscureText: true,
            ),
            SizedBox(height: 10),
            Container(
              width: 200,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorBoton
                ),
                onPressed: (){
                  
                }, 
                child: Text(
                  'Registrarse',
                  style: TextStyle(color: colorLetraB)
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}