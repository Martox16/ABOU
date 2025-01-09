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
        backgroundColor: Color(0xFF372FC0),
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
              padding: EdgeInsets.only(left: 8),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: Text(
                'Documentos',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        centerTitle: false,
        toolbarHeight: 60,
      ),
      body: Container(
        color: Color(0xFFF0F0F0), // Fondo uniforme
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight, // Asegura que el contenido ocupe al menos toda la altura disponible
                ),
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: _toggleCard,
                      child: _isCardOpened
                          ? Column(
                              children: [
                                GestureDetector(
                                  onTap: _toggleCard,
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(15), // Radio para la parte superior
                                        bottom: Radius.zero,
                                      ),
                                      child: Image.asset(
                                        'lib/img/cardMINIdniABIERTOprimeraparte.jpg',
                                        width: 0.9 * MediaQuery.of(context).size.width,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => DNI()),
                                    );
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.zero,
                                        bottom: Radius.circular(15), // Radio para la parte inferior
                                      ),
                                      child: Image.asset(
                                        'lib/img/cardMINIdniABIERTOsegundaparte.jpg',
                                        width: 0.9 * MediaQuery.of(context).size.width,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Container(
                              alignment: Alignment.center,
                              child: ClipRRect(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15), // Borde redondeado para todos los lados
                                ),
                                child: Image.asset(
                                  'lib/img/cardMINIdni.jpg',
                                  width: 0.9 * MediaQuery.of(context).size.width,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                    ),
                  ],
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
            Navigator.pushNamed(context, '/inicio'); // Navegar a inicio.dart
          } else if (dx <= footerWidth * 0.50) {
            Navigator.pushNamed(context, '/novedades'); // Navegar a novedades.dart
          } else {
            String url = 'https://wa.me/541139101010?text=¡Hola!%20Quiero%20hacerte%20una%20consulta.';
            launchURL(url); // Abrir el URL de WhatsApp
          }
        },
        child: Container(
          height: MediaQuery.of(context).size.height * 0.08,
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
