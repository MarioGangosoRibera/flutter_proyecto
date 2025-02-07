import 'package:flutter/material.dart';
import '../model/Colores.dart';
import 'PantallaPrincipal.dart';
import '../database/databaseHelper.dart';

/// PantallaPerfil es un widget que muestra la información del perfil del usuario,
/// incluyendo el correo electrónico, teléfono y dirección de consulta.
/// También permite al usuario cerrar sesión.
class PantallaPerfil extends StatelessWidget {
  /// Instancia de [DatabaseHelper] para interactuar con la base de datos.
  DatabaseHelper dbHelper = DatabaseHelper();

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
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'info@albadonadonutricion.com',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Telefono',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              '+34 698911465',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Consulta presencial',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'LoMás Recoletas Salud (Valladolid) C/Juan Antonio Morales Pintor',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Container(
                width: 200,
                child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: colorBoton),
                    onPressed: () {
                      // Cierra la sesión y navega a la pantalla principal
                      dbHelper.cerrarSesion();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PantallaPrincipal()),
                      );
                    },
                    child: Text(
                      'Cerrar sesión',
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