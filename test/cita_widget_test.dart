import 'package:Proyecto_segundaEv/model/cita_widget.dart';
import 'package:Proyecto_segundaEv/model/Cita.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('CitaWidget muestra la fecha y hora correctamente', (WidgetTester tester) async {
    // Crea una instancia del widget
    await tester.pumpWidget(MaterialApp(
      home: CitaWidget(
        cita: Cita(
          idCita: 1,
          fecha: '2025-02-07',
          hora: '10:00',
          idUsuario: 1,
          idServicio: 1,
        ),
      ),
    ));

    // Verifica que la fecha y hora se muestren correctamente
    expect(find.text('2025-02-07'), findsOneWidget);
    expect(find.text('10:00'), findsOneWidget);
  });
}