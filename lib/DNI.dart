import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';
import 'verDetalles.dart';
// Importa el archivo inicio.dart
import 'package:url_launcher/url_launcher.dart'; // Importar para usar launchURL

class DNI extends StatefulWidget {
  @override
  _DNIState createState() => _DNIState();
}

class _DNIState extends State<DNI> {
  bool isFront = true;
  double angle = 0.0;
  String currentDate = DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now());

  void _navigateToPreviousPage() {
    Navigator.pop(context);
  }

  void _navigateToVerDetalles() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => VerDetalles()),
    );
  }

  void _updateCurrentDate() {
    setState(() {
      currentDate = DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now());
    });
  }

  void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'No se pudo abrir $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0F0F0),
      body: GestureDetector(
        onTapDown: (TapDownDetails details) {
          double screenWidth = MediaQuery.of(context).size.width;
          double touchX = details.globalPosition.dx;
          double touchY = details.globalPosition.dy;

          // Navegar atrás solo si se toca la parte izquierda de la imagen 'headerDNI.png'
          if (touchX < screenWidth * 0.14 && touchY < 100) {
            _navigateToPreviousPage();
          }
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Imagen del header con detección de toque para navegar hacia atrás
              GestureDetector(
                onTapDown: (TapDownDetails details) {
                  double touchX = details.localPosition.dx;
                  if (touchX < 50) {
                    _navigateToPreviousPage();
                  }
                },
                child: Container(
                  width: double.infinity,
                  child: Image.asset('lib/img/headerDNI.jpg', fit: BoxFit.cover),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Card(
                      color: Colors.white,
                      elevation: 5,
                      margin: EdgeInsets.symmetric(vertical: 16),
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'MARTIN ELIEZER CYGIEL',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 16),
                            GestureDetector(
                              onHorizontalDragUpdate: (details) {
                                setState(() {
                                  if (isFront) {
                                    angle += details.delta.dx * -0.01;
                                  } else {
                                    angle += details.delta.dx * 0.01;
                                  }
                                  angle = angle.clamp(0.0, pi);
                                });
                              },
                              onHorizontalDragEnd: (details) {
                                setState(() {
                                  if (isFront && angle > pi / 2) {
                                    angle = pi;
                                    isFront = false;
                                  } else if (!isFront && angle < pi / 2) {
                                    angle = 0;
                                    isFront = true;
                                  } else if (isFront) {
                                    angle = 0;
                                  } else {
                                    angle = pi;
                                  }
                                });
                              },
                              child: Transform(
                                transform: Matrix4.rotationY(angle),
                                alignment: Alignment.center,
                                child: angle <= pi / 2
                                    ? Image.asset('lib/img/carnetAdelante.png')
                                    : Transform(
                                        transform: Matrix4.rotationY(pi),
                                        alignment: Alignment.center,
                                        child: Image.asset('lib/img/carnetAtras.png'),
                                      ),
                              ),
                            ),
                            SizedBox(height: 16),
                            Center(
                              child: Image.asset(
                                isFront ? 'lib/img/puntoCambioA.png' : 'lib/img/puntoCambioB.png',
                                width: 30,
                                height: 30,
                              ),
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Última actualización $currentDate',
                              style: TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                            SizedBox(height: 16),
                            // División de la imagen en tres áreas táctiles
                            GestureDetector(
                              onTapDown: (TapDownDetails details) {
                                double touchX = details.localPosition.dx;
                                double imageWidth = 300; // Cambiar según el ancho de la imagen

                                // Dividir la imagen en tres partes
                                if (touchX < imageWidth / 3) {
                                  // Solo esta sección lleva a verDetalles.dart
                                  _navigateToVerDetalles();
                                }
                                // Las demás áreas no realizan ninguna acción
                              },
                              child: Image.asset(
                                'lib/img/datosDNI.png',
                                width: double.infinity,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTapDown: (TapDownDetails details) {
          double footerWidth = MediaQuery.of(context).size.width;
          double dx = details.globalPosition.dx;

          if (dx <= footerWidth * 0.25) {
            Navigator.pushNamed(context, '/inicio'); // Navegar a inicio.dart
          } else if (dx <= footerWidth * 0.50) {
            Navigator.pushNamed(context, '/novedades'); // Navegar a novedades.dart
          } else {
            String url = 'https://wa.me/541139101010?text=¡Hola!%20Quiero%20hacerte%20una%20consulta.';
            launchURL(url); // Abrir el URL de WhatsApp
          }
        },
        child: Container(
          height: MediaQuery.of(context).size.height * 0.08, // Altura del footer ajustada proporcionalmente
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('lib/img/footer.png'), // Asegúrate de que el path sea correcto
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
