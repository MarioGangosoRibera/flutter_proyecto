import 'package:flutter/material.dart';
import 'Colores.dart';
import 'PantallaServicios.dart';

class PantallaLogin extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/imagenes/LogoAlba.png', height: 200),
            Container(
              width: 300,
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Correo electrónico',
                  filled: true
                ),
              ),
            ),
            SizedBox(height: 10,),
            Container(
              width: 300,
              child: TextField(
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
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => PantallaServicios()),
                  );
                }, 
                child: Text(
                  'Iniciar sesión',
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