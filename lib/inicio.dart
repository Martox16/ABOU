import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
// Importa las páginas correspondientes
import 'MisDocumentos.dart'; // MisDocumentos.dart
import 'MisVehiculos.dart';  // MisVehiculos.dart
import 'MisTurnos.dart';     // MisTurnos.dart
import 'miSalud.dart';      // miSalud.dart
import 'misCobros.dart';    // misCobros.dart
import 'misTramites.dart';  // misTramites.dart
import 'misHijos.dart';     // misHijos.dart
import 'miTrabajo.dart';    // miTrabajo.dart
import 'miPerfil.dart';     // miPerfil.dart

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
      MisDocumentos(),
      MisVehiculos(),
      MiTrabajo(),
      MiSalud(),
      MisCobros(),
      MisTramites(),
      MisTurnos(),
      MisHijos(),
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
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MiPerfil()),
                    );
                  },
                ),
              ],
            ),
          ),
          centerTitle: true,
        ),
      ),
      body: Container(
        color: Color(0xFFF0F0F0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      LayoutBuilder(
                        builder: (context, constraints) {
                          return Center(
                            child: Image.asset(
                              'lib/img/turnosProgramados.jpg',
                              width: constraints.maxWidth * 0.9,
                              fit: BoxFit.contain,
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 20),
                      Center(
                        child: Image.asset('lib/img/todasTusCredenciales.png'),
                      ),
                      SizedBox(height: 20),
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
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation, secondaryAnimation) {
                                    return destinationPages[index];
                                  },
                                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                    const begin = Offset(1.0, 0.0);
                                    const end = Offset.zero;
                                    const curve = Curves.easeInOut;

                                    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                                    var offsetAnimation = animation.drive(tween);

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
                      SizedBox(height: 20),
                      Center(
                        child: Image.asset(
                          'lib/img/completaTuPerfil.png',
                          width: constraints.maxWidth * 0.8,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
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
