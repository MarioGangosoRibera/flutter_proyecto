import 'package:Proyecto_segundaEv/model/Cita.dart';
import 'package:flutter_test/flutter_test.dart';
void main() {
  group('Cita', () {
    test('debe crear una instancia de Cita correctamente', () {
      final cita = Cita(
        idCita: 1,
        fecha: '2025-02-07',
        hora: '10:00',
        idUsuario: 123,
        idServicio: 456,
      );

      expect(cita.idCita, 1);
      expect(cita.fecha, '2025-02-07');
      expect(cita.hora, '10:00');
      expect(cita.idUsuario, 123);
      expect(cita.idServicio, 456);
    });
  });
}