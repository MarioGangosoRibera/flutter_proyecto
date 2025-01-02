import 'package:flutter/material.dart';
import 'Colores.dart';
import 'Pantalla_principal.dart';
import 'database_helper.dart';

class PantallaPerfil extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/imagenes/LogoAlba.png', height: 200),
            Text(
              'E-mail',
              style: TextStyle(
                fontWeight: FontWeight.bold
              ),
            ),
            Text(
              'info@albadonadonutricion.com',
              style: TextStyle(
                fontWeight: FontWeight.bold
              ),  
            ),
            SizedBox(height: 10),
            Text(
              'Telefono',
              style: TextStyle(
                fontWeight: FontWeight.bold
              ),
            ),
            Text(
              '+34 698911465',
              style: TextStyle(
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Consulta presencial',
              style: TextStyle(
                fontWeight: FontWeight.bold
              ),
            ),
            Text(
              'LoMás Recoletas Salud (Valladolid) C/Juan Antonio Morales Pintor',
              style: TextStyle(
                fontWeight: FontWeight.bold
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

                }, 
                child: Text(
                  'Cerrar sesion',
                  style: TextStyle(color: colorLetraB),  
                )
              )
            )
          ],
        ),
      ),
    );
  }
}