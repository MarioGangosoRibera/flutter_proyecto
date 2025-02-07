import 'package:flutter/material.dart';
import 'PantallaLogin.dart';
import 'PantallaResgistro.dart';
import '../model/Colores.dart';

/// PantallaPrincipal es un widget que sirve como la pantalla de inicio de la aplicación.
/// Proporciona opciones para iniciar sesión o registrarse.
class PantallaPrincipal extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/imagenes/LogoAlba.png', height: 200),
            SizedBox(height: 10),
            Container(
              width: 200,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorBoton,
                ),
                onPressed: () {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => PantallaLogin()),
                  );
                },
                child: Text(
                  'Iniciar sesión',
                  style: TextStyle(color: colorLetraB),
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: 200,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorBoton,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PantallaRegistro()),
                  );
                },
                child: Text(
                  'Registrarse',
                  style: TextStyle(color: colorLetraB),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}