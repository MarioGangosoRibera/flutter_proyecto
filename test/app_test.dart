// test_driver/app_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../lib/main.dart' as app;

void main() {

  testWidgets("Flujo de inicio de sesión", (WidgetTester tester) async {
    // Iniciar la aplicación
    app.main();
    await tester.pumpAndSettle();

    // Verificar que estamos en la pantalla de inicio de sesión
    expect(find.text("Iniciar Sesión"), findsOneWidget);

    // Ingresar el correo y la contraseña
    await tester.enterText(find.byKey(Key("correoField")), "test@example.com");
    await tester.enterText(find.byKey(Key("contrasenaField")), "password123");

    // Tocar el botón de inicio de sesión
    await tester.tap(find.byKey(Key("loginButton")));
    await tester.pumpAndSettle();

    // Verificar que se redirige a la pantalla principal después de iniciar sesión
    expect(find.text("Bienvenido"), findsOneWidget);
  });
}