import 'package:Proyecto_segundaEv/model/Colores.dart';
import 'package:flutter/material.dart';
import 'PantallaCalendarioCitas.dart';
import 'PantallaPerfil.dart';
import 'PantallaCitas.dart';

/// PantallaServicios es un widget que muestra una lista de servicios
/// disponibles y permite a los usuarios seleccionar un servicio para
/// pedir una cita o ver su perfil.
class PantallaServicios extends StatefulWidget {
  final List<String> servicios = [
    'Pérdida de peso y recomposición corporal',
    'Nutrición en patologias deportivas',
    'Alimentación vegetariana y vegana',
    'Nutrición clínica',
    'Trastornos de la Conducta Alimentaria'
  ];

  @override
  _PantallaServiciosState createState() => _PantallaServiciosState();
}

class _PantallaServiciosState extends State<PantallaServicios> {
  int _selectedIndex = 0; // Inicialmente en la pantalla de servicios

  // Lista de pantallas
  final List<Widget> _screens = [
    PantallaServiciosContent(),
    PantallaCalendarioCitas(
      idUsuario: 1,
    ),
    PantallaPerfil()
  ];

/// Cambia la pantalla mostrada según el índice seleccionado en la barra de navegación.
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.medical_services_outlined),
            label: 'Servicios',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Citas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: colorBoton,
        onTap: _onItemTapped,
      ),
    );
  }
}

/// PantallaServiciosContent es un widget que muestra el contenido de los servicios
/// disponibles, incluyendo imágenes y botones para pedir citas.
class PantallaServiciosContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/imagenes/LogoAlba.png', height: 50),
                  SizedBox(width: 10),
                  Text(
                    'Mis servicios',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 250,
                        width: 450,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(15)),
                          image: DecorationImage(
                            image: AssetImage('assets/imagenes/Servicio1.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        width: 250,
                        child: Text(
                          'Pérdida de peso y recomposición corporal',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: colorBoton),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PantallaCitas(
                                servicioSeleccionado:
                                    'Pérdida de peso y recomposición corporal',
                                idUsuario: 1,
                              ),
                            ),
                          );
                        },
                        child: Text(
                          'Pedir cita',
                          style: TextStyle(color: colorLetraB),
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  )),
              Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 250,
                        width: 450,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(15)),
                          image: DecorationImage(
                            image: AssetImage('assets/imagenes/Servicio2.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        width: 250,
                        child: Text(
                          'Nutrición en patologias deportivas',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: colorBoton),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PantallaCitas(
                                      servicioSeleccionado:
                                          'Nutrición en patologias deportivas',
                                      idUsuario: 1,
                                    )),
                          );
                        },
                        child: Text(
                          'Pedir cita',
                          style: TextStyle(color: colorLetraB),
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  )),
              Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 250,
                        width: 450,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(15)),
                          image: DecorationImage(
                            image: AssetImage('assets/imagenes/Servicio3.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        width: 250,
                        child: Text(
                          'Alimentación vegetariana y vegana',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      // Botón debajo del texto
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: colorBoton),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PantallaCitas(
                                servicioSeleccionado:
                                    'Alimentación vegetariana y vegana',
                                idUsuario: 1,
                              ),
                            ),
                          );
                        },
                        child: Text(
                          'Pedir cita',
                          style: TextStyle(color: colorLetraB),
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  )),
              Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 250,
                        width: 450,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(15)),
                          image: DecorationImage(
                            image: AssetImage('assets/imagenes/Servicio4.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        width: 250,
                        child: Text(
                          'Nutrición clínica',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: colorBoton),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PantallaCitas(
                                servicioSeleccionado: 'Nutrición clínica',
                                idUsuario: 1,
                              ),
                            ),
                          );
                        },
                        child: Text(
                          'Pedir cita',
                          style: TextStyle(color: colorLetraB),
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  )),
              Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 250,
                        width: 450,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(15)),
                          image: DecorationImage(
                            image: AssetImage('assets/imagenes/Servicio5.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        width: 250,
                        child: Text(
                          'Trastornos de la Conducta Alimentaria',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: colorBoton),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PantallaCitas(
                                servicioSeleccionado:
                                    'Trastornos de la Conducta Alimentaria',
                                idUsuario: 1,
                              ),
                            ),
                          );
                        },
                        child: Text(
                          'Pedir cita',
                          style: TextStyle(color: colorLetraB),
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  )),
              Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 250,
                        width: 450,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(15)),
                          image: DecorationImage(
                            image: AssetImage('assets/imagenes/Servicio6.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        width: 250,
                        child: Text(
                          'Charlas y talleres de educación alimentaria',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  )
                ),
            ],
          ),
        ),
      ),
    );
  }
}
