import 'package:flutter/material.dart';
import 'inicio.dart'; // Importa el archivo inicio.dart
import 'DNI.dart'; // Importa el archivo contraDNI.dart
import 'package:url_launcher/url_launcher.dart'; // Importar para usar launchURL

class MisDocumentos extends StatefulWidget {
  @override
  _MisDocumentosState createState() => _MisDocumentosState();
}

class _MisDocumentosState extends State<MisDocumentos> {
  bool _isCardOpened = false;

  void _toggleCard() {
    setState(() {
      _isCardOpened = !_isCardOpened;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFF3773BC),
        title: Row(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) => HomePage(),
                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                      var begin = Offset(-1.0, 0.0);
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
            Text('Mis documentos', style: TextStyle(color: Colors.white)),
          ],
        ),
        centerTitle: true,
        toolbarHeight: 50, // Ajustar la altura del AppBar
      ),
      body: Container(
        color: Colors.grey.shade200,
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: _toggleCard,
                child: _isCardOpened
                    ? Column(
                        children: [
                          GestureDetector(
                            onTap: _toggleCard,
                            child: Image.asset(
                              'lib/img/cardMINIdniABIERTOprimeraparte.png',
                              width: double.infinity,
                              fit: BoxFit.contain,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => DNI()),
                              );
                            },
                            child: Image.asset(
                              'lib/img/cardMINIdniSegundaParte.png',
                              width: double.infinity,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ],
                      )
                    : Image.asset(
                        'lib/img/cardMINIdni.png',
                        width: double.infinity,
                        fit: BoxFit.contain,
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
