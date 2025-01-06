import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Importa url_launcher para abrir URLs
import 'package:auto_size_text/auto_size_text.dart';
import 'MisDocumentos.dart'; // Importa el archivo MisDocumentos.dart
import 'MisVehiculos.dart';
import 'MisTurnos.dart'; // Importa el archivo MisTurnos.dart
import 'miSalud.dart';
import 'misCobros.dart';
import 'misTramites.dart';
import 'misHijos.dart';
import 'miTrabajo.dart';

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
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100), // Aumenta la altura del header
        child: AppBar(
          automaticallyImplyLeading: false, // Deshabilita la flecha de navegación
          backgroundColor: Color(0xFF372FC0),
          title: Padding(
            padding: const EdgeInsets.only(top: 16.0), // Ajusta el padding superior del header
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Image.asset(
                    'lib/img/menuNav.png',
                    width: 32, // Aumenta el tamaño del ícono
                    height: 32,
                  ),
                  onPressed: () {},
                ),
                Image.asset(
                  'lib/img/iconoArg.png',
                  height: 32, // Aumenta el tamaño del logo
                ),
                IconButton(
                  icon: Image.asset(
                    'lib/img/logoPerfil.png',
                    width: 32, // Aumenta el tamaño del ícono
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
        color: Color(0xFFF0F0F0), // Fondo de la página en gris claro
        
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Image.asset('lib/img/turnosProgramados.jpg'),
                 
               Card(
   color: Color(0xFFF0F0F0),
  elevation: 0, // Hace que el borde sea invisible
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
        GridView.count(
          crossAxisCount: 4, // Cambiar a 4 columnas
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [
            ServiceIcon(
              imagePath: 'lib/img/iconoDocumentos.png',
              label: 'Documentos',
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) => MisDocumentos(),
                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                      var begin = Offset(1.0, 0.0);
                      var end = Offset.zero;
                      var curve = Curves.ease;
                      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                      return SlideTransition(
                        position: animation.drive(tween),
                        child: child,
                      );
                                    },
                                  ),
                                );
                              },
                            ),
                            ServiceIcon(
                              imagePath: 'lib/img/iconoVehiculos.png',
                              label: 'Mis vehículos',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation, secondaryAnimation) => MisVehiculos(),
                                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                      var begin = Offset(1.0, 0.0);
                                      var end = Offset.zero;
                                      var curve = Curves.ease;

                                      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                                      return SlideTransition(
                                        position: animation.drive(tween),
                                        child: child,
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                            ServiceIcon(
                              imagePath: 'lib/img/iconoSalud.png',
                              label: 'Mi salud',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation, secondaryAnimation) => MiSalud(),
                                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                      var begin = Offset(1.0, 0.0);
                                      var end = Offset.zero;
                                      var curve = Curves.ease;

                                      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                                      return SlideTransition(
                                        position: animation.drive(tween),
                                        child: child,
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                            ServiceIcon(
                              imagePath: 'lib/img/iconoTrabajo.png',
                              label: 'Mi trabajo',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation, secondaryAnimation) => MiTrabajo(),
                                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                      var begin = Offset(1.0, 0.0);
                                      var end = Offset.zero;
                                      var curve = Curves.ease;

                                      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                                      return SlideTransition(
                                        position: animation.drive(tween),
                                        child: child,
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                            ServiceIcon(
                              imagePath: 'lib/img/iconoTurnos.png',
                              label: 'Mis turnos',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation, secondaryAnimation) => MisTurnos(),
                                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                      var begin = Offset(1.0, 0.0);
                                      var end = Offset.zero;
                                      var curve = Curves.ease;

                                      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                                      return SlideTransition(
                                        position: animation.drive(tween),
                                        child: child,
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                            ServiceIcon(
                              imagePath: 'lib/img/iconoCobros.png',
                              label: 'Mis cobros',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation, secondaryAnimation) => MisCobros(),
                                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                      var begin = Offset(1.0, 0.0);
                                      var end = Offset.zero;
                                      var curve = Curves.ease;

                                      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                                      return SlideTransition(
                                        position: animation.drive(tween),
                                        child: child,
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                            ServiceIcon(
                              imagePath: 'lib/img/iconoTramites.png',
                              label: 'Mis trámites',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation, secondaryAnimation) => MisTramites(),
                                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                      var begin = Offset(1.0, 0.0);
                                      var end = Offset.zero;
                                      var curve = Curves.ease;

                                      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                                      return SlideTransition(
                                        position: animation.drive(tween),
                                        child: child,
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                            ServiceIcon(
                              imagePath: 'lib/img/iconoHijos.png',
                              label: 'Mis hijos',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation, secondaryAnimation) => MisHijos(),
                                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                      var begin = Offset(1.0, 0.0);
                                      var end = Offset.zero;
                                      var curve = Curves.ease;

                                      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                                      return SlideTransition(
                                        position: animation.drive(tween),
                                        child: child,
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                          ],
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
            Navigator.pushNamed(context, '/inicio'); // Navegar a inicio
          } else if (dx <= footerWidth * 0.50) {
            Navigator.pushNamed(context, '/novedades'); // Navegar a novedades
          } else {
            String url = 'https://wa.me/541139101010?text=¡Hola!%20Quiero%20hacerte%20una%20consulta.';
            launchURL(url); // Abrir el URL de WhatsApp
          }
        },
        child: Container(
          height: 60, // Ajusta la altura del footer según sea necesario
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('lib/img/footer.png'),
              fit: BoxFit.cover, // Ajusta la imagen para que cubra el footer
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

class ServiceIcon extends StatelessWidget {
  final String imagePath;
  final String label;
  final VoidCallback? onTap;

  const ServiceIcon({
    required this.imagePath,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double imageSize = constraints.maxWidth * 0.6; // Ajusta el tamaño basado en el espacio disponible
        return InkWell(
          onTap: onTap, // Asigna el callback onTap
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                imagePath,
                width: imageSize,
                height: imageSize,
              ),
              SizedBox(height: 10),
              Flexible(
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14, // Ajusta el tamaño de la fuente
                    overflow: TextOverflow.ellipsis, // Asegura que el texto no se divida
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
