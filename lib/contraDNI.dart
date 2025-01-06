import "package:flutter/material.dart";
import 'DNI.dart'; // Importa el archivo DNI.dart

class ContraDNI extends StatefulWidget {
  @override
  _ContraDNIState createState() => _ContraDNIState();
}

class _ContraDNIState extends State<ContraDNI> {
  final String headerImagePath = 'lib/img/headerDNIDIGITAL.png';
  final String pinImagePath = 'lib/img/ingresaPIN.png';

  void _navigateToPreviousPage() {
    Navigator.pop(context);
  }

  void _navigateToDNI() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => DNI(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset(0.0, 0.0);
          const curve = Curves.ease;

          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0F0F0), // Color de fondo
      body: GestureDetector(
        onTapDown: (TapDownDetails details) {
          if (details.globalPosition.dx < MediaQuery.of(context).size.width * 0.14) {
            _navigateToPreviousPage();
          }
        },
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: Image.asset(headerImagePath, fit: BoxFit.cover),
            ),
            GestureDetector(
              onTap: _navigateToDNI,
              child: Container(
                padding: const EdgeInsets.only(top: 10.0), // Reduce el padding superior para acercar la imagen al encabezado
                alignment: Alignment.topCenter,
                child: Image.asset(pinImagePath, width: MediaQuery.of(context).size.width * 0.9), // Reduce un poco el ancho de la imagen
              ),
            ),
          ],
        ),
      ),
    );
  }
}
