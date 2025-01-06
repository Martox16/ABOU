import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Importa url_launcher para abrir URLs
// Importa las páginas correspondientes
import 'MisDocumentos.dart'; // MisDocumentos.dart
import 'MisVehiculos.dart';  // MisVehiculos.dart
import 'MisTurnos.dart';     // MisTurnos.dart
import 'miSalud.dart';      // miSalud.dart
import 'misCobros.dart';    // misCobros.dart
import 'misTramites.dart';  // misTramites.dart
import 'misHijos.dart';     // misHijos.dart
import 'miTrabajo.dart';    // miTrabajo.dart

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'mi Argentina',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Lista de las rutas de las imágenes
    final List<String> imagePaths = [
      'lib/img/iconoDocumentos.png',
      'lib/img/iconoVehiculos.png',
      'lib/img/iconoTrabajo.png',
      'lib/img/iconoSalud.png',
      'lib/img/iconoCobros.png',
      'lib/img/iconoTramites.png',
      'lib/img/iconoTurnos.png',
      'lib/img/iconoHijos.png',
    ];

    final List<Widget> destinationPages = [
      MisDocumentos(), // Pantalla para los documentos
      MisVehiculos(),  // Pantalla para vehículos
      MiTrabajo(),     // Pantalla para trabajo
      MiSalud(),       // Pantalla para salud
      MisCobros(),     // Pantalla para cobros
      MisTramites(),   // Pantalla para trámites
      MisTurnos(),     // Pantalla para turnos
      MisHijos(),      // Pantalla para hijos
    ];

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xFF372FC0),
          title: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Image.asset(
                    'lib/img/menuNav.png',
                    width: 32,
                    height: 32,
                  ),
                  onPressed: () {},
                ),
                Image.asset(
                  'lib/img/iconoArg.png',
                  height: 32,
                ),
                IconButton(
                  icon: Image.asset(
                    'lib/img/logoPerfil.png',
                    width: 32,
                    height: 32,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          centerTitle: true,
        ),
      ),
      body: Container(
        color: Color(0xFFF0F0F0),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset('lib/img/turnosProgramados.jpg'),
                Card(
                  color: Color(0xFFF0F0F0),
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '¿Qué necesitas hoy?',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 20),
                        
                        GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                          ),
                          itemCount: imagePaths.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                // Navega a la página correspondiente con una animación personalizada
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation, secondaryAnimation) {
                                      return destinationPages[index];
                                    },
                                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                      // Definimos la animación de transición
                                      const begin = Offset(1.0, 0.0); // La nueva pantalla viene desde la derecha
                                      const end = Offset.zero; // La nueva pantalla se establece en su posición final
                                      const curve = Curves.easeInOut; // Curva de la animación

                                      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                                      var offsetAnimation = animation.drive(tween);

                                      // Aplicamos la animación al contenido de la pantalla
                                      return SlideTransition(position: offsetAnimation, child: child);
                                    },
                                  ),
                                );
                              },
                              child: Image.asset(
                                imagePaths[index],
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTapDown: (TapDownDetails details) {
          double footerWidth = MediaQuery.of(context).size.width;
          double dx = details.globalPosition.dx;

          if (dx <= footerWidth * 0.25) {
            Navigator.pushNamed(context, '/inicio');
          } else if (dx <= footerWidth * 0.50) {
            Navigator.pushNamed(context, '/novedades');
          } else {
            String url = 'https://wa.me/541139101010?text=¡Hola!%20Quiero%20hacerte%20una%20consulta.';
            launchURL(url);
          }
        },
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('lib/img/footer.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'No se pudo abrir $url';
    }
  }
}
