import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MisHijos extends StatelessWidget {
  final String headerImagePath = 'lib/img/headerMisHijos.jpg';
  final String cardImagePath = 'lib/img/cardMisHijos.jpg';
  final String footerImagePath = 'lib/img/footer.png';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0F0F0), // Color de fondo
      body: Stack(
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
                    double leftLimit = headerWidth * 0.14;

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
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          String url = 'https://wa.me/541139101010?text=¡Hola!%20Quiero%20hacerte%20una%20consulta.';
                          launchURL(url); // Abrir el enlace de WhatsApp cuando se toque la imagen
                        },
                        child: Image.asset(
                          cardImagePath,
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                        ),
                      ),
                      // Puedes agregar más contenido aquí según sea necesario
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: GestureDetector(
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
                    image: AssetImage(footerImagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ],
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
