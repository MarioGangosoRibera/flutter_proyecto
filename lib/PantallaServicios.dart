import 'package:Proyecto_segundaEv/Colores.dart';
import 'package:flutter/material.dart';
import 'PantallaCalendario.dart';
import 'PantallaPerfil.dart';

class PantallaServicios extends StatefulWidget {
  @override
  _PantallaServiciosState createState() => _PantallaServiciosState();
}

class _PantallaServiciosState extends State<PantallaServicios> {
  int _selectedIndex = 0; // Inicialmente en la pantalla de servicios

  // Lista de pantallas
  final List<Widget> _screens = [
    PantallaServiciosContent(),
    PantallaCalendario(), // Contenido de servicios
    PantallaPerfil() // Pantalla de perfil
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex], // Muestra la pantalla seleccionada
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
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20), //Espacio entre el titulo y la card
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 200,
                      width: 250,
                      decoration: BoxDecoration(
                         borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
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
                    // Botón debajo del texto
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorBoton
                      ),
                      onPressed: () {
                        
                      },
                      child: Text(
                        'Pedir cita',
                        style: TextStyle(color: colorLetraB),
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                )
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 200,
                      width: 250,
                      decoration: BoxDecoration(
                         borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
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
                    // Botón debajo del texto
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorBoton
                      ),
                      onPressed: () {
                        
                      },
                      child: Text(
                        'Pedir cita',
                        style: TextStyle(color: colorLetraB),
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                )
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 200,
                      width: 250,
                      decoration: BoxDecoration(
                         borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                        image: DecorationImage(
                          image: AssetImage('assets/imagenes/Servicio3.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                        width: 250,
                        child: Text(
                        'Alimentacion vegetariana y vegana',
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
                        backgroundColor: colorBoton
                      ),
                      onPressed: () {
                        
                      },
                      child: Text(
                        'Pedir cita',
                        style: TextStyle(color: colorLetraB),
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                )
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 200,
                      width: 250,
                      decoration: BoxDecoration(
                         borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
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
                    // Botón debajo del texto
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorBoton
                      ),
                      onPressed: () {
                        
                      },
                      child: Text(
                        'Pedir cita',
                        style: TextStyle(color: colorLetraB),
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                )
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 200,
                      width: 250,
                      decoration: BoxDecoration(
                         borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
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
                    // Botón debajo del texto
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorBoton
                      ),
                      onPressed: () {
                        
                      },
                      child: Text(
                        'Pedir cita',
                        style: TextStyle(color: colorLetraB),
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                )
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 200,
                      width: 250,
                      decoration: BoxDecoration(
                         borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
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
                    // Botón debajo del texto
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorBoton
                      ),
                      onPressed: () {
                        
                      },
                      child: Text(
                        'Pedir cita',
                        style: TextStyle(color: colorLetraB),
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