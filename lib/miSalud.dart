import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MiSalud extends StatelessWidget {
  final String headerImagePath = 'lib/img/headerMiSalud.jpg';
  final String cardImagePath = 'lib/img/cardUnoSalud.jpg';
  final String cardImagePathDos = 'lib/img/cardDosSalud.png';
  final String cardImagePathTres = 'lib/img/cardTresSalud.png';
  final String footerImagePath = 'lib/img/footer.png';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0F0F0), // Fondo uniforme
      body: Container(
        color: Color(0xFFF0F0F0), // Asegura un fondo consistente
        child: Stack(
          fit: StackFit.expand,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Flexible(
                  flex: 1,
                  child: GestureDetector(
                    onTapDown: (TapDownDetails details) {
                      double headerWidth = MediaQuery.of(context).size.width;
                      double leftLimit = headerWidth * 0.15;

                      if (details.globalPosition.dx <= leftLimit) {
                        Navigator.pop(context); // Volver a la página anterior
                      }
                    },
                    child: Image.asset(
                      headerImagePath,
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return SingleChildScrollView(
                        physics: BouncingScrollPhysics(), // Efecto de rebote al hacer scroll
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: constraints.maxHeight, // Asegura que el fondo cubra toda la pantalla
                          ),
                          child: Column(
                            children: [
                              Image.asset(
                                cardImagePath,
                                fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.width,
                              ),
                              Image.asset(
                                cardImagePathDos,
                                fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.width,
                              ),
                              Image.asset(
                                cardImagePathTres,
                                fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.width,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTapDown: (TapDownDetails details) {
                  double footerWidth = MediaQuery.of(context).size.width;
                  double dx = details.globalPosition.dx;

                  if (dx <= footerWidth * 0.25) {
                    Navigator.pushNamed(context, '/inicio'); // Navegar a inicio.dart
                  } else if (dx <= footerWidth * 0.50) {
                    Navigator.pushNamed(context, '/novedades'); // Navegar a novedades.dart (verifica si esta ruta existe)
                  } else {
                    String url = 'https://wa.me/541139101010?text=¡Hola!%20Quiero%20hacerte%20una%20consulta.';
                    launchURL(url); // Abrir el URL de WhatsApp
                  }
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.08, // Altura del footer ajustada proporcionalmente
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(footerImagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ],
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
