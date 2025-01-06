import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Importar para usar launchURL

class VerDetalles extends StatelessWidget {
  void _navigateToPreviousPage(BuildContext context) {
    Navigator.pop(context);
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
            _navigateToPreviousPage(context);
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
                    _navigateToPreviousPage(context);
                  }
                },
                child: Container(
                  width: double.infinity,
                  child: Image.asset('lib/img/headerDNI.jpg', fit: BoxFit.cover),
                ),
              ),
              SizedBox(height: 8), // Espacio reducido entre el header y la card
              // Contenedor para la imagen infoDNI
              Container(
                width: double.infinity, // Ocupa todo el ancho de la pantalla
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(0), // Sin bordes redondeados
                  child: Image.asset(
                    'lib/img/infoDNI.png',
                    fit: BoxFit.fill, // Ajuste para cubrir todo el contenedor
                    width: double.infinity,
                  ),
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

  void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'No se pudo abrir $url';
    }
  }
}
